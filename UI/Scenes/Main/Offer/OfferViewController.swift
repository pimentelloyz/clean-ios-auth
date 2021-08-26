import UIKit

public final class OfferViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView! {
        didSet {
            searchContainerView.clipsToBounds = true
            searchContainerView.layer.cornerRadius = 24
        }
    }
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.backgroundColor = Color.backgroundPrimary
        tableView.separatorStyle = .none
    }
}
