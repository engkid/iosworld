import Foundation
import Combine
import Factory

final class HomeTabViewModel: ObservableObject {
    let title: String
    let subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

final class FeedTabViewModel: ObservableObject {
    let title: String
    let subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

final class ProfileTabViewModel: ObservableObject {
    let title: String
    let subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

final class ArticlesTabViewModel: ObservableObject {
    let title: String
    let subtitle: String

    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

extension Container {
  
    var homeTabViewModel: Factory<HomeTabViewModel> {
        Factory(self) {
            HomeTabViewModel(
                title: "Home",
                subtitle: "Welcome back! Explore updates and highlights."
            )
        }
    }

    var feedTabViewModel: Factory<FeedTabViewModel> {
        Factory(self) {
            FeedTabViewModel(
                title: "Feed",
                subtitle: "Your personalized feed appears here."
            )
        }
    }
  
    var profileTabViewModel: Factory<ProfileTabViewModel> {
        Factory(self) {
            ProfileTabViewModel(
                title: "Profile",
                subtitle: "Manage your account and preferences."
            )
        }
    }

    var articlesTabViewModel: Factory<ArticlesTabViewModel> {
        Factory(self) {
            ArticlesTabViewModel(
                title: "Articles",
                subtitle: "Read curated stories and insights."
            )
        }
    }
}
