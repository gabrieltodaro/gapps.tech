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

            Link("Ctrlavana", target: "https://gabrieltodaro.github.io/ctrlavana-site/").target(.blank)
        }
        .padding(12)
        .navigationItemAlignment(.trailing)
        .navigationBarStyle(.dark)
        .background(.indigo)
        .position(.fixedTop)
    }
}
