//
// Home.swift
// 
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation
import Ignite

struct Home: StaticPage {
    var title = "Home"

    func body(context: PublishingContext) async -> [BlockElement] {
        Carousel {
            Slide(background: "/images/ctrlavana-background2.png") {
                Text("Ctrlavana")
                    .font(.title1)

                Text("My first app is out! Check it out")
                    .font(.lead)

                Link("Check it out here", target: "http://ctrlavana.gapps.tech")
                    .linkStyle(.button)
            }
            .backgroundOpacity(0.5)

            Slide(background: "/images/articles/swiftui-with-gemini.png") {
                Text("Do you know you can integrate Gemini in a SwiftUI app?")
                    .font(.title1)

                Text {
                    Link("Check it out here", target: "/article/2024/swiftui-with-gemini/")
                        .linkStyle(.button)
                }
            }
            .backgroundOpacity(0.25)

            Slide(background: "/images/gapps-tech.png") {
                Text("More updates coming soon.")
                    .font(.title1)

                Text("I'm running through the busiest year of my life. But I'll be back.")
                    .font(.lead)
            }
            .backgroundOpacity(0.25)

        }
        .padding(.top, 24)

    }
}
