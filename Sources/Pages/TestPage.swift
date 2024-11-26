//
//  TestPage.swift
//
//
//  Created by Gabriel Patané Todaro on 05/06/24.
//

import Foundation
import Ignite

struct TestPage: StaticPage {
	var title = "Teste Page"

	func body(context: PublishingContext) -> [BlockElement] {
		Text("Testing page")
	}
}
