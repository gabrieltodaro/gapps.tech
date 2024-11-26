//
//  GappsFooter.swift
//  GappsTech
//
//  Created by Gabriel Patané Todaro on 26/11/24.
//

import Foundation
import Ignite

public struct GappsFooter: Component {
    public init() { }

    public func body(context: PublishingContext) -> [any PageElement] {
        Text {
            "Created with "
            Link("Ignite", target: URL("https://github.com/twostraws/Ignite")).target(.blank)
            " and "
            Link("Swift", target: URL("https://developer.apple.com/swift/")).target(.blank)
        }
        .horizontalAlignment(.center)
        .margin(.top, .extraLarge)
    }
}
