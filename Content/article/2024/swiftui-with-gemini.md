---
author: Gabz Todaro
description: How to implement Gemini with SwiftUI?
date: 2024-06-06 15:30
tags: Swift, SwiftUI, Artificial Inteligence
published: true
image: /images/articles/swiftui-with-gemini.png
---
# INTEGRATING SWIFTUI WITH GEMINI

Hey guys, what’s up?

Last week I was learning about Gemini’s API and AI Studio and, out of nowhere, I was recommended this video from Etisha Garg. It’s a really nice video, with really good teaching skills. Shout out to Etisha, and I can’t wait to see what she’s doing next!

[![Watch the video](https://img.youtube.com/vi/6Ibvt5W5FbA/maxresdefault.jpg)](https://www.youtube.com/watch?v=6Ibvt5W5FbA)

And, after watching that video, I wanted to do a “step forward” with the Gemini integration.
First things first.

## AI Studio
 ![AI Studio](/images/articles/swiftui-with-gemini-ai-studio-0.png)

#### Safety Settings
For those who don’t know, AI Studio is the place where you can “try” new stuffs. Play with Gemini, Gemini models, some safety settings, the “temperature for creativity” and more. It’s really nice to know these things if you want to implement AI in your systems. Explaining details used in this post:

*API* – the key to communicate with Gemini. You can get one in the left panel, “Get API key”. Mine won’t be shared, but it’s easy to get yours!

*Model* – the model used for generating content. We’re going to use the Gemini 1.0 Pro (the most stable version right now);

*Temperature* – how “creative” the AI will be. From 0 to 1, where 0 is really strict to fact (as much it can be), and 1 is “wow, I’ll invent things here and will be awesome!”.

*Safety Settings* – This is the place where you can control what can be passed to the model. You can control “Harassment”, “Hate”, “Sexually Explicit”, “Dangerous Content”, and you control them from blocking none to blocking most. It cannot guarantee you that will block everything, that’s why you don’t have this option.

So, let’s build our view to control our model and play with different types of creativity?
I’m starting after building and integrating with Gemini from Etisha’s video. So check it out first (and leave your like on her video, she deserves that)!

## Creating a new Settings View

As we are going to create a new view to control Safety Settings and Temperature, it would be nice to create an enum to not put magical strings all over our code. So, let’s start creating our SafetySettingsEnum. The text computed property is just to show on our Picker.

```swift
// These strings are the ones we need to create our object to pass to Gemini.
enum SafetySettingsEnum: String, CaseIterable {
	case blockNone = "BLOCK_NONE"
	case blockFew = "BLOCK_ONLY_HIGH"
	case blockSome = "BLOCK_MEDIUM_AND_ABOVE"
	case blockMost = "BLOCK_LOW_AND_ABOVE"

	var text: String {
		switch self {
		case .blockNone:
			return "None"
		case .blockFew:
			return "Few"
		case .blockSome:
			return "Some"
		case .blockMost:
			return "Most"
		}
	}
}
```

Important to mention the `saveAction` variable. This is a way to bind this action within the previous view, but you can do it the way you want!

```swift
import SwiftUI

struct SettingsView: View {

	@AppStorage(CustomSettingsKeyEnum.custom.rawValue)
	private var useCustomSettings = false

	@AppStorage(CustomSettingsKeyEnum.temperature.rawValue)
	private var temperatureSettings: Double = 0.5

	@AppStorage(CustomSettingsKeyEnum.safetyHarassment.rawValue)
	private var harassmentSettings = SafetySettingsEnum.blockNone
	
	@AppStorage(CustomSettingsKeyEnum.safetyHate.rawValue)
	private var hateSettings = SafetySettingsEnum.blockNone
	
	@AppStorage(CustomSettingsKeyEnum.safetySexual.rawValue)
	private var sexualSettings = SafetySettingsEnum.blockNone
	
	@AppStorage(CustomSettingsKeyEnum.safetyDanger.rawValue)
	private var dangerousSettings = SafetySettingsEnum.blockNone

	var saveAction: () -> Void

	var body: some View {
		VStack(spacing: 0) {
			Form {

				Section("Custom Settings") {
					Toggle("Use custom settings", isOn: $useCustomSettings.animation(.spring))
				}

				if useCustomSettings {
					Section("Temperature") {
						Text("Temperate: \(temperatureSettings, specifier: "%.2f")")
						Slider(value: $temperatureSettings, in: 0.01...1.00, step: 0.01)
					}

					Section("Safety Settings") {
						Picker("Harassment", selection: $harassmentSettings) {
							ForEach(SafetySettingsEnum.allCases, id: \.self) {
								Text($0.text)
							}
						}

						Picker("Hate", selection: $hateSettings) {
							ForEach(SafetySettingsEnum.allCases, id: \.self) {
								Text($0.text)
							}
						}

						Picker("Sexually Explicit", selection: $sexualSettings) {
							ForEach(SafetySettingsEnum.allCases, id: \.self) {
								Text($0.text)
							}
						}

						Picker("Dangerous Content", selection: $dangerousSettings) {
							ForEach(SafetySettingsEnum.allCases, id: \.self) {
								Text($0.text)
							}
						}
					}
				}

				Button("Save", action: saveAction)
					.frame(maxWidth: .infinity, alignment: .center)
					.padding(.vertical)
			}
		}
	}
}

#Preview {
	SettingsView(saveAction: {})
}
```

I’m showing this Settings view as a modal over our Content Generation view, so it’ll be easier to pass our Save Action. You can call this view the way you want to!

```swift
/// Adding button on our view
Button(action: { showingSettings = true }, 
  label: {
    Image(systemName: "gear")
  })
.font(.title)

/// Enabling our Settings view as a modal
.sheet(isPresented: $showingSettings) {
  SettingsView(saveAction: updateModel)
}
```

![Settings View](/images/articles/swiftui-with-gemini-settings-view-resized.png)

Regarding our SettingsView, I opted to put every custom setting in our UserDefaults, using the @AppStorage macro. However, you can create them as `@Binding` or, even better, creating an `@ObservableObject` (famously known as ViewModel) and putting everything as its properties. Suit yourself and let your curiosity take you further!

Alright, getting back to our code, you have probably seen that `updateModel` action, right? Let’s dive in:

```swift
private func updateModel() {
    // 1.
		if useCustomSettings {
			let defaults = UserDefaults.standard

      // 2.
			let harassment = defaults.string(forKey: CustomSettingsKeyEnum.safetyHarassment.rawValue) ?? SafetySettingsEnum.blockNone.rawValue
			let hate = defaults.string(forKey: CustomSettingsKeyEnum.safetyHate.rawValue) ?? SafetySettingsEnum.blockNone.rawValue
			let sexual = defaults.string(forKey: CustomSettingsKeyEnum.safetySexual.rawValue) ?? SafetySettingsEnum.blockNone.rawValue
			let danger = defaults.string(forKey: CustomSettingsKeyEnum.safetyDanger.rawValue) ?? SafetySettingsEnum.blockNone.rawValue

			let temperature = defaults.double(forKey: CustomSettingsKeyEnum.temperature.rawValue)

      // 3.
			let generationConfig = GenerationConfig(temperature: Float(temperature))
			let safetySettings = [
				SafetySetting(harmCategory: .harassment,
							  threshold: SafetySetting.BlockThreshold(rawValue: harassment) ?? .unspecified),
				SafetySetting(harmCategory: .hateSpeech,
							  threshold: SafetySetting.BlockThreshold(rawValue: hate) ?? .unspecified),
				SafetySetting(harmCategory: .sexuallyExplicit,
							  threshold: SafetySetting.BlockThreshold(rawValue: sexual) ?? .unspecified),
				SafetySetting(harmCategory: .dangerousContent,
							  threshold: SafetySetting.BlockThreshold(rawValue: danger) ?? .unspecified)
			]

      // 4.
			model = GenerativeModel(name: ContentGenerateView.geminiModelName,
									apiKey: APIKeyEnum.gemini,
									generationConfig: generationConfig,
									safetySettings: safetySettings)
			showingSettings = false
		} else {
			model = GenerativeModel(name: ContentGenerateView.geminiModelName, apiKey: APIKeyEnum.gemini)
			showingSettings = false
		}
	}
```

This is where the magic happens. Let’s separate our code in 4 topics:

Verifying if we should create a custom model or use the “basic one” (the else statement);

Getting values from UserDefaults (or wherever you placed it)
Here I’m creating a “block none” string from our SafetySettingsEnum if, somehow, the value is nil. After that, we’re creating the SafetySetting object, from Gemini, passing our string. If it fails, we’re creating it using the .unspecified object.

Creating our configuration models with those values
I’m not using Top P, but we can try it in a later post!

Replacing our current model with the new configured one and dismissing the settings view;

And that would do everything you need!

Now, the tricky part is to test it. I’d suggest to test it on Studio before, then try on your app. And it’s going to be based on what type of settings you put on.

So, we’ve just seen how to integrate with Google’s Gemini SDK, thanks to Etisha, and how to create Safety Settings and Generation Config to pass it to our GenerativeModel object.

That’s it!

Thanks for reaching this point and let me know if I can assist you somehow.
