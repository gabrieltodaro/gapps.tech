//
//  BlogPosts.swift
//  GappsTech
//
//  Created by Gabriel Patané Todaro on 20/11/24.
//

import Foundation
import Ignite

struct BlogPosts: StaticPage {
    var title = "Blog Posts"

    func body(context: PublishingContext) -> [BlockElement] {
        Section {
            for item in context.allContent {
                Card(imageName: item.image) {
                    Text(item.description)
                        .margin(.bottom, .none)
                } header: {
                    Text {
                        Link(item)
                    }
                    .font(.title5)
                }
                .width(3)
                .margin(.bottom)
            }
        }
    }
}
