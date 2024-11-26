import Foundation
import Ignite

@main
struct IgniteWebsite {
    static func main() async {
        let site = GappsSite()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct GappsSite: Site {    
    let name = "Gapps.Tech"
    let url: URL = URL("https://www.gapps.tech")
    let builtInIconsEnabled = true

	var syntaxHighlighters = [SyntaxHighlighter.swift, .python]
//	var feedConfiguration = FeedConfiguration(mode: .full,
//											  contentCount: 20,
//											  image: .init(url: "https://www.yoursite.com/images/icon32.png",
//														   width: 32,
//														   height: 32))
    var author = "Gabz Todaro"

    var homePage = Home()
	var tagPage = Tags()
    var theme = MyTheme()

	var pages: [any StaticPage] {
        BlogPosts()
	}

	var layouts: [any ContentPage] {
		Story()
	}
}


