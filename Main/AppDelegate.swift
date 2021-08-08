import UIKit
import UI
import Firebase
import FBSDKCoreKit
import MSAL

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
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
    
    func application(_ app: UIApplication, open url: URL, options:[UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let handled: Bool = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[.sourceApplication] as? String, annotation: options[.annotation])
        MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String)
        return handled
    }
}

