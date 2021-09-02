import Foundation
import UIKit

public class AddProductViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    
    struct Storyboard {
        static let addProductImputTableViewCell = String(describing: AddProductImputTableViewCell.self)
    }
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNib()
        tableView.reloadData()
    }

    func registerNib() {
        let productNib = UINib(nibName: Storyboard.addProductImputTableViewCell, bundle: nil)
        tableView.register(productNib, forCellReuseIdentifier: Storyboard.addProductImputTableViewCell)
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Color.backgroundPrimary
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.backgroundPrimary
        tableView.separatorStyle = .none
    }
}

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.addProductImputTableViewCell, for: indexPath) as! AddProductImputTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}
