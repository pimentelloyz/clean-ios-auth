import UIKit
import UI
import FBSDKCoreKit
import FacebookCore
import MSAL

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    static let nav = NavigationController()
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        
        let loadScreenController = makeLoadScreenController(nav: SceneDelegate.nav)
        SceneDelegate.nav.setRootViewController(loadScreenController)
        window?.rootViewController = SceneDelegate.nav
        window?.makeKeyAndVisible()
    }
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else {
              return
           }

        let url = urlContext.url
        ApplicationDelegate.shared.application( UIApplication.shared, open: url, sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation])
       
           let sourceApp = urlContext.options.sourceApplication
           MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: sourceApp)
    }
}
