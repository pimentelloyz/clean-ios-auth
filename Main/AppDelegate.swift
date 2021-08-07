import UIKit
import UI
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        if #available(iOS 13.0, *) { } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let loadScreenController = makeLoadScreenController(nav: SceneDelegate.nav)
            SceneDelegate.nav.setRootViewController(loadScreenController)
            window.rootViewController = SceneDelegate.nav
            window.makeKeyAndVisible()
        }
        return true
    }
}

