import UIKit
import UI

public func makeMainTabBarController() -> UITabBarController {
    return makeMainTabBarControllerWith()
}

public func makeMainTabBarControllerWith() -> UITabBarController {
    SceneDelegate.nav.setNavigationBarHidden(true, animated: true)
    let tabController = UITabBarController()
    tabController.navigationController?.navigationBar.isHidden = true
    //let homeViewController = makeHomeViewController()
    //let studyPlanViewController = StudyPlanViewController.instantiate()
    //let attendanceViewController = makeAttendanceViewController()
    //let solidarityActionViewController = SolidarityActionViewController.instantiate()
    //let galleryViewController = makeGaleryViewController()
    
    let tabBarDelegate = TabBarDelegate()
    
    let vcData: [(UIViewController, UIImage, UIImage, String)] = [
        (HomeViewController.instantiate(), UIImage(named: "home")!, UIImage(named: "home_selected")!, "Home"),
        (OfferViewController.instantiate(), UIImage(named: "offer")!, UIImage(named: "offer_selected")!, "Ofertas"),
        (PriceViewController.instantiate(), UIImage(named: "price")!, UIImage(named: "price_selected")!, "Preços"),
        (SettingsViewController.instantiate(), UIImage(named: "settings")!, UIImage(named: "settings_selected")!, "Configurações"),
        
        //(galleryViewController, UIImage(named: "gallery")!, UIImage(named: "gallery-selected")!)
    ]

    let vcs = vcData.map { (vc, defaultImage, selectedImage, title) -> UINavigationController in
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.image = defaultImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.title = title
        return nav
    }
    
    tabController.viewControllers = vcs
    tabController.tabBar.isTranslucent = true
    tabController.delegate = tabBarDelegate
    if let items = tabController.tabBar.items {
        for item in items {
            if let image = item.image {
                item.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            }
            if let selectedImage = item.selectedImage {
                item.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            }
            item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    UINavigationBar.appearance().backgroundColor = Color.backgroundPrimary
    return tabController
}
