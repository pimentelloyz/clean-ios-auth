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
            appendNewProjects()
        }
    }
    var products: [LoadProductNotRegisteredByAccountBodyViewModel]?

    public var loadProductNotRegisteredByAccount: ((LoadProductNotRegisteredByAccountRequest) -> Void)?
    public var goToAddProductViewController: ((LoadProductNotRegisteredByAccountBodyViewModel) -> Void)?
    
    struct Storyboard {
        static let productNotRegisteredTableViewCell = String(describing: ProductNotRegisteredTableViewCell.self)
    }
    var loadProductNotRegisteredOffsetViewModel = LoadProductNotRegisteredOffsetViewModel()
    var loadProductControll: LoadProductControll = LoadProductControll.hasCompleted
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNib()
        fetchProductNotRegisteredByAccount()
    }
    
    func setup() {
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
        loadProductNotRegisteredByAccount?(LoadProductNotRegisteredByAccountRequest(limit: loadProductNotRegisteredOffsetViewModel.limit, offSet: loadProductNotRegisteredOffsetViewModel.offset, search: loadProductNotRegisteredOffsetViewModel.search))
    }
    
    func appendNewProjects() {
        guard let safeViewModel = self.viewModel else { return }
        let newElements = safeViewModel.listProductBody()
        if newElements.isEmpty {
            self.loadProductNotRegisteredOffsetViewModel.decrementOffset()
            return
        }
        if products == nil  {
            products = newElements
        } else {
            products! += newElements
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchDidTap(_ sender: Any) {
        fetchProductNotRegisteredByAccount()
    }
}

extension ProductNotRegisteredViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productNotRegisteredTableViewCell, for: indexPath) as! ProductNotRegisteredTableViewCell
        cell.selectionStyle = .none
        let product = self.products?[indexPath.row]
        cell.product = product
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = self.products?[indexPath.row] else { return }
        self.goToAddProductViewController?(product)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
            switch loadProductControll {
            case .hasCompleted:
                self.loadProductNotRegisteredOffsetViewModel.incrementOffset()
                self.fetchProductNotRegisteredByAccount()
            case .isLoadingMore:
                break
            }
        }
    }
}

extension ProductNotRegisteredViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let safeText = textField.text else {
            return true
        }
        
        self.products?.removeAll()
        self.loadProductNotRegisteredOffsetViewModel.updateSearchQuery(newQuery: safeText)
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else {
            return true
        }
        self.fetchProductNotRegisteredByAccount()
        return true
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
