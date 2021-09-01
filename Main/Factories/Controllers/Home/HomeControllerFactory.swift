import Foundation
import Presentation
import Validation
import Domain

public func makeHomeViewController() -> HomeViewController {
    return makeHomeViewControllerWith()
}

public func makeHomeViewControllerWith() -> HomeViewController {
    let controller = HomeViewController.instantiate()
    return controller
}
