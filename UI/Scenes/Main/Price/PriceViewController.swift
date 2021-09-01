import UIKit
import Presentation

public final class PriceViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView! {
        didSet {
            searchContainerView.clipsToBounds = true
            searchContainerView.layer.cornerRadius = 24
        }
    }
    var viewModel: LoadProductRegisteredByAccountViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    public var loadProductRegisteredByAccount: ((LoadProductRegisteredByAccountRequest) -> Void)?
    
    struct Storyboard {
        static let productCell = String(describing: ProductTableViewCell.self)
    }
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNib()
        fetchProductRegisteredByAccount()
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Color.backgroundPrimary
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.backgroundPrimary
        tableView.separatorStyle = .none
    }
    
    func registerNib() {
        let productNib = UINib(nibName: Storyboard.productCell, bundle: nil)
        tableView.register(productNib, forCellReuseIdentifier: Storyboard.productCell)
    }
    
    func fetchProductRegisteredByAccount() {
        loadProductRegisteredByAccount?(LoadProductRegisteredByAccountRequest(limit: 10, offSet: 0, search: "%"))
    }
}

extension PriceViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productCell, for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        let product = self.viewModel?.productByIndex(indexPath.row)
        cell.product = product
        return cell
    }
}

extension PriceViewController: LoadProductRegisteredByAccountResultViewModel {
    public func result(_ viewModel: LoadProductRegisteredByAccountViewModel) {
        self.viewModel = viewModel
    }
}

extension PriceViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
        } else {
            view.isUserInteractionEnabled = true
        }
    }
}

extension PriceViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
