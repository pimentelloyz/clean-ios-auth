import UIKit

public final class HomeViewController: UIViewController, Storyboarded {
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = Color.backgroundPrimary
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
