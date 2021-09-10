import UIKit
import Presentation

public final class PriceViewController: UIViewController, Storyboarded {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
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
    public var removeProductAccount: ((PathComponentRequest) -> Void)?
    
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
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        products?.removeAll()
        loadProductRegisteredOffsetViewModel.resetDefaultvalues()
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
        loadProductControll = .isLoadingMore
        loadProductRegisteredByAccount?(LoadProductRegisteredByAccountRequest(limit: loadProductRegisteredOffsetViewModel.limit, offSet: loadProductRegisteredOffsetViewModel.offset, search: loadProductRegisteredOffsetViewModel.search))
    }
    
    func appendNewProjects() {
        guard let safeViewModel = self.viewModel else { return }
        let newElements = safeViewModel.listProductBody()
        if newElements.isEmpty {
            if self.loadProductRegisteredOffsetViewModel.offset != 0 {
                self.loadProductRegisteredOffsetViewModel.decrementOffset()
            }
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
    
    func handleDidTapLogout(indexPath: IndexPath) {
        let product = products?[indexPath.row]
        self.selectedProduct = product
        guard let productViewModel = self.selectedProduct else { return }
        let alert = UIAlertController(title: "\(productViewModel.productName)", message: "", preferredStyle: .actionSheet)
        let removeAction = UIAlertAction(title: "REMOVE".localized(), style: .destructive) { _ in
            self.handleRemoveDidTapLogout(productViewModel: productViewModel)
        }
        
        let editAction = UIAlertAction(title: "EDIT".localized(), style: .default) { _ in
            self.goToAddProductViewController?(productViewModel)
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL".localized(), style: .cancel)
        alert.addAction(editAction)
        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func handleRemoveDidTapLogout(productViewModel: LoadProductRegisteredByAccountBodyViewModel) {
        let alert = UIAlertController(title: "CONFIRM_REMOVE_REMOVE_TITLE".localized(), message: "CONFIRM_REMOVE_PRODCUT_MESSAGE".localized(), preferredStyle: .alert)
        let action = UIAlertAction(title: "CONFIRM_BUTTON".localized(), style: .destructive) { _ in
            self.removeProductAccount?(PathComponentRequest(path: "\(productViewModel.accountProductId)"))
        }
        let cancelAction = UIAlertAction(title: "CANCEL".localized(), style: .cancel)
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    @IBAction func addNewProductDidTap(_ sender: Any) {
        goToProductNotRegisteredViewController?()
    }
    
    @IBAction func searchDidTap(_ sender: Any) {
        guard let safeText = searchTextField.text else { return }
        self.products?.removeAll()
        self.loadProductRegisteredOffsetViewModel.resetDefaultOffset()
        self.loadProductRegisteredOffsetViewModel.updateSearchQuery(newQuery: safeText)
        fetchProductRegisteredByAccount()
    }
    
    @IBAction func withoutPriceDidChange(_ sender: UISwitch) {
//        loadProductRegisteredOffsetViewModel.resetDefaultvalues()
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
            cell.indexPath = indexPath
            cell.showMenuDelegate = self
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.productCell, for: indexPath) as! ProductTableViewCell
        cell.selectionStyle = .none
        
        cell.product = product
        cell.indexPath = indexPath
        cell.showMenuDelegate = self
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleDidTapLogout(indexPath: indexPath)
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

extension PriceViewController: ProductOptionsDidTapDelegate {
    public func showMenu(by indexPath: IndexPath) {
        handleDidTapLogout(indexPath: indexPath)
    }
}

extension PriceViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let safeText = textField.text else { return true }
        self.products?.removeAll()
        self.loadProductRegisteredOffsetViewModel.resetDefaultOffset()
        self.loadProductRegisteredOffsetViewModel.updateSearchQuery(newQuery: safeText)
        self.fetchProductRegisteredByAccount()
        return true
    }
}

extension PriceViewController: LoadProductRegisteredByAccountResultViewModel {
    public func result(_ viewModel: LoadProductRegisteredByAccountViewModel) {
        self.viewModel = viewModel
        self.loadProductControll = .hasCompleted
    }
}

extension PriceViewController: ResultNoContentViewModel {
    public func result(_ viewModel: NoContentViewModel) {
        self.products?.removeAll()
        self.loadProductRegisteredOffsetViewModel.resetDefaultOffset()
        self.loadProductRegisteredOffsetViewModel.resetDefaultvalues()
        self.fetchProductRegisteredByAccount()
    }
}

extension PriceViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
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
