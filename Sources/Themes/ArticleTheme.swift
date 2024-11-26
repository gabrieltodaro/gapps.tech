//
// ArticleTheme.swift
// IgniteSamples
// https://www.github.com/twostraws/Ignite
// See LICENSE for license information.
//

import Foundation
import Ignite

struct ArticleTheme: Theme {
	func render(page: Page, context: PublishingContext) async -> HTML {
		HTML {
			RemoteHead(for: page, in: context)

			Body {
				// TODO: Implement navbar
//				NavBar()

				Section {
					Group {
						page.body
					}
					.width(9)
					.padding(.vertical, 80)

					Group {
						Text("Read this next…")
							.font(.title3)

						if let latest = context.allContent.randomElement() {
							ContentPreview(for: latest)
						}
					}
					.width(3)
					.position(.stickyTop)
					.padding(.top, 80)
				}

				IgniteFooter()
			}
		}
	}
}
