import Foundation
import Combine
import Factory
import Home

final class FeedViewModel: ObservableObject {
  let title: String
  let subtitle: String
  
  init(title: String, subtitle: String) {
    self.title = title
    self.subtitle = subtitle
  }
}

final class ProfileViewModel: ObservableObject {
  let title: String
  let subtitle: String
  
  init(title: String, subtitle: String) {
    self.title = title
    self.subtitle = subtitle
  }
}

final class ArticlesViewModel: ObservableObject {
  let title: String
  let subtitle: String
  
  init(title: String, subtitle: String) {
    self.title = title
    self.subtitle = subtitle
  }
}

extension Container {
  
  var feedViewModel: Factory<FeedViewModel> {
    Factory(self) {
      FeedViewModel(
        title: "Feed",
        subtitle: "Your personalized feed appears here."
      )
    }
  }
  
  var profileViewModel: Factory<ProfileViewModel> {
    Factory(self) {
      ProfileViewModel(
        title: "Profile",
        subtitle: "Manage your account and preferences."
      )
    }
  }
  
  var articlesViewModel: Factory<ArticlesViewModel> {
    Factory(self) {
      ArticlesViewModel(
        title: "Articles",
        subtitle: "Read curated stories and insights."
      )
    }
  }
  
  var moduleManager: Factory<ModuleManaging> {
    Factory(self) {
      ModuleManager()
    }.scope(.singleton)
  }
  
  var tabRouter: Factory<TabRouting> {
    Factory(self) {
      TabRouter()
    }.singleton
  }
}
