import Domain
import Navigation
import MovieFeature
import SerieFeature
import MediaFeature


struct AppRouter {
  static func registerRoutes() {
    Router.shared.register(route: NavigationRoute(path: "/movies", destination: MoviesView()))
    Router.shared.register(route: NavigationRoute(path: "/tv-shows", destination: SeriesView()))
    Router.shared.register(route: NavigationRoute(path: "/media-details", destination: MediaDetailsView()))
  }
}
