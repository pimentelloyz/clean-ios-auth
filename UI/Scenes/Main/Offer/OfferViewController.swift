import UIKit

public final class OfferViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView! {
        didSet {
            searchContainerView.clipsToBounds = true
            searchContainerView.layer.cornerRadius = 24
        }
    }
    
    struct Storyboard {
        static let productCell = String(describing: ProductTableViewCell.self)
    }
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNib()
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.backgroundPrimary
        tableView.separatorStyle = .none
    }
    
    func registerNib() {
        let productNib = UINib(nibName: Storyboard.productCell, bundle: nil)
        tableView.register(productNib, forCellReuseIdentifier: Storyboard.productCell)
    }
}

extension OfferViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productCell, for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
