import UIKit

public final class OfferViewController: UIViewController, Storyboarded {
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Color.backgroundPrimary
    }
}
