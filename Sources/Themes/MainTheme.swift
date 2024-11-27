//
// MainTheme.swift
// 
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation
import Ignite

struct MyTheme: Theme {
    func render(page: Page, context: PublishingContext) -> HTML {
        HTML {
            RemoteHead(for: page, in: context)

            Body {
				HeaderNavBar()
				
                page.body

                GappsFooter()
            }
            .style("background-color: #fef9d6;")
			.padding(.vertical, 120)
			.class("container")
        }
    }
}
