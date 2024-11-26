//
//  File.swift
//
//
//  Created by Gabriel Patané Todaro on 06/06/24.
//

import Foundation
import Ignite

struct HeaderNavBar: Component {
    func body(context: PublishingContext) -> [any PageElement] {
        NavigationBar(logo: Image("/images/logo-horizontal-claro.png",
                                  description: "Site Logo")
            .resizable()
            .frame(maxWidth: "200px")
            .padding()
        ) {
            Link("Blog Posts", target: BlogPosts())
            
            Dropdown("Contact") {
                Link("LinkedIn", target: "https://linkedin.com/in/gabrieltodaro")
                    .target(.blank)
                
                Link("E-mail", target: "mailto:gabz@gapps.tech")
                    .target(.blank)
                
                Link("Twitter", target: "https://x.com/gabztodaro")
                    .target(.blank)
            }
            //			Dropdown("Key concepts") {
            //				Link("Grid Layout", target: GridExamples())
            //				Link("Navigation", target: NavigationExamples())
            //				Link("Content", target: ContentExamples())
            //				Link("Text", target: TextExamples())
            //				Link("Styling", target: StylingExamples())
            //			}
            //
            //			Dropdown("Examples") {
            //				Link("Accordions", target: AccordionExamples())
            //				Link("Alerts", target: AlertExamples())
            //				Link("Badges", target: BadgeExamples())
            //				Link("Buttons", target: ButtonExamples())
            //				Link("Cards", target: CardExamples())
            //				Link("Carousels", target: CarouselExamples())
            //				Link("Code", target: CodeExamples())
            //				Link("Dropdowns", target: DropdownExamples())
            //				Link("Embeds", target: EmbedExamples())
            //				Link("Images", target: ImageExamples())
            //				Link("Includes", target: IncludeExamples())
            //				Link("Links", target: LinkExamples())
            //				Link("Lists", target: ListExamples())
            //				Link("Quotes", target: QuoteExamples())
            //				Link("Tables", target: TableExamples())
            //			}
            
            Link("Ctrlavana", target: "https://gabrieltodaro.github.io/ctrlavana-site/").target(.blank)
        }
        .navigationItemAlignment(.trailing)
        .navigationBarStyle(.dark)
        .background(.indigo)
        .position(.fixedTop)
    }
}
