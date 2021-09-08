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
            appendNewProjects()
        }
    }
    var products: [LoadProductRegisteredByAccountBodyViewModel]?
    var selectedProduct: LoadProductRegisteredByAccountBodyViewModel?
    public var loadProductRegisteredByAccount: ((LoadProductRegisteredByAccountRequest) -> Void)?
    public var goToProductNotRegisteredViewController: (() -> Void)?
    public var goToAddProductViewController: ((LoadProductRegisteredByAccountBodyViewModel) -> Void)?

    struct Storyboard {
        static let productCell = String(describing: ProductTableViewCell.self)
        static let productSignatureCell = String(describing: ProductSignatureTableViewCell.self)
    }
    var loadProductRegisteredOffsetViewModel = LoadProductRegisteredOffsetViewModel()
    var loadProductControll: LoadProductControll = LoadProductControll.hasCompleted
    
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
        let productSignatureNib = UINib(nibName: Storyboard.productSignatureCell, bundle: nil)
        tableView.register(productSignatureNib, forCellReuseIdentifier: Storyboard.productSignatureCell)
    }
    
    func fetchProductRegisteredByAccount() {
        loadProductRegisteredByAccount?(LoadProductRegisteredByAccountRequest(limit: loadProductRegisteredOffsetViewModel.limit, offSet: loadProductRegisteredOffsetViewModel.offset, search: loadProductRegisteredOffsetViewModel.search))
    }
    
    func appendNewProjects() {
        guard let safeViewModel = self.viewModel else { return }
        let newElements = safeViewModel.listProductBody()
        if newElements.isEmpty {
            self.loadProductRegisteredOffsetViewModel.decrementOffset()
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
    
    @IBAction func addNewProductDidTap(_ sender: Any) {
        goToProductNotRegisteredViewController?()
    }
    
    @IBAction func searchDidTap(_ sender: Any) {
        fetchProductRegisteredByAccount()
    }
}

extension PriceViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products?[indexPath.row]
        if product?.isSignature ?? false {
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productSignatureCell, for: indexPath) as! ProductSignatureTableViewCell
            cell.selectionStyle = .none
            cell.product = product
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productCell, for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        
        cell.product = product
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products?[indexPath.row]
        self.selectedProduct = product
        guard let productViewModel = self.selectedProduct else { return }
        self.goToAddProductViewController?(productViewModel)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
            switch loadProductControll {
            case .hasCompleted:
                self.loadProductRegisteredOffsetViewModel.incrementOffset()
                self.fetchProductRegisteredByAccount()
            case .isLoadingMore:
                break
            }
        }
    }
}

extension PriceViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let safeText = textField.text else {
            return true
        }
        
        self.loadProductRegisteredOffsetViewModel.updateSearchQuery(newQuery: safeText)
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != nil else {
            return true
        }
        self.fetchProductRegisteredByAccount()
        return true
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
