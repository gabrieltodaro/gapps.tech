import Foundation
import Ignite

public struct RemoteHead: HTMLRootElement {
  typealias HeadElementBuilder = ElementBuilder<HeadElement>
    /// The metadata elements for this page.
    var items: [HeadElement]

    /// Creates a new `Head` instance using an element builder that returns
    /// an array of `HeadElement` objects.
    /// - Parameter items: The `HeadElement` items you want to
    /// include for this page.
    public init(@HeadElementBuilder items: () -> [HeadElement]) {
        self.items = items()
    }

    /// A convenience initializer that creates a standard set of headers to use
    /// for a `Page` instance.
    /// - Parameters:
    ///   - page: The `Page` you want to create headers for.
    ///   - context: The active `PublishingContext`, which includes
    ///   information about the site being rendered and more.
    ///   - additionalItems: Additional items to enhance the set of standard headers.
    public init(
        for page: Page,
        in context: PublishingContext,
        @HeadElementBuilder additionalItems: () -> [HeadElement] = {[]}
    ) {
        items = Head.standardHeaders(for: page, in: context)
        items += MetaTag.socialSharingTags(for: page, context: context)
        items += additionalItems()
    }

    /// Renders this element using publishing context passed in.
    /// - Parameter context: The current publishing context.
    /// - Returns: The HTML for this element.
    public func render(context: PublishingContext) -> String {
      "<head>\(items.map { $0.render(context: context) }.joined())</head>"
    }

    /// A static function, returning the standard set of headers used for a `Page` instance.
    ///
    /// This function can be used when defining a custom header based on the standard set of headers.
    /// - Parameters:
    ///   - page: The `Page` you want to create headers for.
    ///   - context: The active `PublishingContext`, which includes
    @HeadElementBuilder
    public static func standardHeaders(for page: Page, in context: PublishingContext) -> [HeadElement] {
        MetaTag.utf8
        MetaTag.flexibleViewport

        if page.description.isEmpty == false {
            MetaTag(name: "description", content: page.description)
        }

        if context.site.author.isEmpty == false {
            MetaTag(name: "author", content: context.site.author)
        }

        MetaTag.generator

        Title(page.title)

      MetaLink(
          href: "https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css",
          rel: .stylesheet)

        if context.site.syntaxHighlighters.isEmpty == false {
            MetaLink.syntaxHighlightingCSS
        }

        if context.site.builtInIconsEnabled {
          MetaLink(
              href: "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css",
              rel: .stylesheet)
        }

        MetaLink(href: page.url, rel: "canonical")

        if let favicon = context.site.favicon {
            MetaLink(href: favicon, rel: .icon)
        }
    }
}
