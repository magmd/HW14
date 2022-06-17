import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)

        let tabBarController = UITabBarController()

        let mediaViewController = MediaViewController()
        let mediaNavigationController = UINavigationController(rootViewController: mediaViewController)
        mediaViewController.tabBarItem = UITabBarItem(title: "Library", image: .init(systemName: "photo.fill.on.rectangle.fill"), tag: 0)

        let forYouViewController = ForYouViewController()
        let forYouNavigationController = UINavigationController(rootViewController: forYouViewController)
        forYouViewController.tabBarItem = UITabBarItem(title: "For You", image: .init(systemName: "heart.text.square.fill"), tag: 1)

        let albumViewController = AlbumViewController()
        let albumNavigationController = UINavigationController(rootViewController: albumViewController)
        albumViewController.tabBarItem = UITabBarItem(title: "Albums", image: .init(systemName: "rectangle.stack.fill"), tag: 2)

        let searchViewController = SearchViewController()
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: .init(systemName: "magnifyingglass"), tag: 3)

        tabBarController.setViewControllers([
            mediaNavigationController,
            forYouNavigationController,
            albumNavigationController,
            searchNavigationController
        ], animated: true)


        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        self.window = window

        return true
    }
}

