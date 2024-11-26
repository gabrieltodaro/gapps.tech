//
//  Story.swift
//
//
//  Created by Gabriel Patané Todaro on 06/06/24.
//

import Foundation
import Ignite

struct Story: ContentPage {
	func body(content: Content, context: PublishingContext) -> [any BlockElement] {
        if let image = content.image {
            Image(image, description: content.imageDescription)
                .resizable()
                .cornerRadius(20)
                .frame(maxWidth: "100%")
                .horizontalAlignment(.center)
        }
        
		Text(content.title)
			.font(.title1)
            .horizontalAlignment(.center)
            .padding(.vertical)

		if content.hasTags {
			Group {
                Section {
                    for tag in content.tags {
                        Text(tag)
                            .horizontalAlignment(.center)
                            .padding(8)
                            .background("#25245E")
                            .foregroundStyle("#FEF9D6")
                            .cornerRadius(8)
                    }
                }

				Text("\(content.estimatedWordCount) words; About \(content.estimatedReadingMinutes) minutes to read.")
                    .horizontalAlignment(.trailing)
                    .foregroundStyle("#25245E")
			}
		}

		Text(content.body)
	}
}

