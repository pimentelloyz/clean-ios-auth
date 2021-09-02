import UIKit
import Presentation

public final class ProductNotRegisteredViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchContainerView: UIView! {
        didSet {
            searchContainerView.clipsToBounds = true
            searchContainerView.layer.cornerRadius = 24
        }
    }
    var viewModel: LoadProductNotRegisteredByAccountViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    public var loadProductNotRegisteredByAccount: ((LoadProductNotRegisteredByAccountRequest) -> Void)?
    public var goToAddProductViewController: (() -> Void)?
    
    struct Storyboard {
        static let productNotRegisteredTableViewCell = String(describing: ProductNotRegisteredTableViewCell.self)
    }
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNib()
        fetchProductNotRegisteredByAccount()
    }
    
    func setup() {
        title = "PRODUCT_NOT_REGISTERED".localized()
        view.backgroundColor = Color.backgroundPrimary
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.backgroundPrimary
        tableView.separatorStyle = .none
    }
    
    func registerNib() {
        let productNib = UINib(nibName: Storyboard.productNotRegisteredTableViewCell, bundle: nil)
        tableView.register(productNib, forCellReuseIdentifier: Storyboard.productNotRegisteredTableViewCell)
    }
    
    func fetchProductNotRegisteredByAccount() {
        loadProductNotRegisteredByAccount?(LoadProductNotRegisteredByAccountRequest(limit: 10, offSet: 0, search: "%"))
    }
}

extension ProductNotRegisteredViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productNotRegisteredTableViewCell, for: indexPath) as! ProductNotRegisteredTableViewCell
        cell.selectionStyle = .none
        let product = self.viewModel?.productByIndex(indexPath.row)
        cell.product = product
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToAddProductViewController?()
    }
}

extension ProductNotRegisteredViewController: LoadProductNotRegisteredByAccountResultViewModel {
    public func result(_ viewModel: LoadProductNotRegisteredByAccountViewModel) {
        self.viewModel = viewModel
    }
}

extension ProductNotRegisteredViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
        } else {
            view.isUserInteractionEnabled = true
        }
    }
}

extension ProductNotRegisteredViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
