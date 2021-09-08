import Foundation
import UIKit
import Presentation

public class AddProductViewController: UIViewController, Storyboarded {
    @IBOutlet weak var productNameLabel: ProductLabel!
    @IBOutlet weak var monthsCountLabel: RegularLabel!
    @IBOutlet weak var tableView: UITableView!
    
    struct Storyboard {
        static let addProductImputTableViewCell = String(describing: AddProductImputTableViewCell.self)
    }
    
    public var productActionManager: ProductActionManager = ProductActionManager.add
    
    public var productViewModel: LoadProductNotRegisteredByAccountBodyViewModel?
    public var productToEditViewModel: LoadProductRegisteredByAccountBodyViewModel?
    
    public var addValueAccountProduct: ((AddValueAccountProductRequest) -> Void)?
    var addValueAccountProductParameters: AddValueAccountProductRequest?
    public var updateValueAccountProduct: ((UpdateValueAccountProductRequest, PathComponentRequest) -> Void)?
    public var updateValueAccountProductRequest: UpdateValueAccountProductRequest?
    public var updateValueAccountProductPath: PathComponentRequest?
    
    public var addSignatureValue: ((AddSignatureValueRequest) -> Void)?
    var addSignatureValueRequest: AddSignatureValueRequest?
    public var updateSignatureValue: ((UpdateSignatureValueRequest, PathComponentRequest) -> Void)?
    public var updateSignatureValueRequest: UpdateSignatureValueRequest?
    public var updateSignatureValuePath: PathComponentRequest?
    
    public final override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        registerNib()
        tableView.reloadData()
        updateUI()
    }

    func registerNib() {
        let productNib = UINib(nibName: Storyboard.addProductImputTableViewCell, bundle: nil)
        tableView.register(productNib, forCellReuseIdentifier: Storyboard.addProductImputTableViewCell)
    }
    
    func setup() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Color.backgroundPrimary
        hideKeyboradOnTap()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.backgroundPrimary
        tableView.separatorStyle = .none
    }
    
    func updateUI() {
        switch productActionManager {
        case .add:
            guard let product = productViewModel else { return }
            productNameLabel.text = product.codeAndNameProduct
            monthsCountLabel.text = product.isSignature ? product.signatureOptions.localized() : ""
            if product.isSignature {
                addSignatureValueRequest = AddSignatureValueRequest(productId: product.productId, signatureItems: [])
            }
        case .update:
            guard let product = productToEditViewModel else { return }
            productNameLabel.text = product.codeAndNameProduct
            monthsCountLabel.text = product.isSignature ? product.signatureOptions.localized() : ""
            if product.isSignature {
                var signatureItems = [UpdateSignatureItemsRequest]()
                product.signatures.map { $0.forEach { signatureItems.append(UpdateSignatureItemsRequest(signatureValueId: $0.signatureValueId, monthCount: $0.monthNumber, salesValue: $0.salesValue))} }
                updateSignatureValueRequest = UpdateSignatureValueRequest(accountProductId: product.accountProductId, signatureItems: signatureItems)
                updateSignatureValuePath = PathComponentRequest(path: "\(product.accountProductId)")
            }
        }
    }
    
    @IBAction func closeDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveProductDidTap(_ sender: Any) {
        switch productActionManager {
        case .add:
            guard let viewModel = productViewModel else { return }
            if viewModel.isSignature {
                guard let parameters = addSignatureValueRequest else { return }
                addSignatureValue?(parameters)
            } else {
                guard let parameters = addValueAccountProductParameters else { return }
                addValueAccountProduct?(parameters)
            }
        case .update:
            guard let viewModel = productToEditViewModel else { return }
            if viewModel.isSignature {
                guard let request = updateSignatureValueRequest else { return }
                guard let path = updateSignatureValuePath else { return }
                updateSignatureValue?(request, path)
            } else {
                guard let request = updateValueAccountProductRequest else { return }
                guard let path = updateValueAccountProductPath else { return }
                updateValueAccountProduct?(request, path)
            }
        }
    }
}

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch productActionManager {
        case .add:
            return productViewModel?.numberOfRowsOnAddProductView() ?? 0
        default:
            return productToEditViewModel?.numberOfRowsOnAddProductView() ?? 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.addProductImputTableViewCell, for: indexPath) as! AddProductImputTableViewCell
        cell.productActionManager = productActionManager
        cell.indexPath = indexPath
        switch productActionManager {
        case .add:
            guard let viewModel = self.productViewModel else {
                return UITableViewCell()
            }
            
            if viewModel.isSignature {
                cell.selectionStyle = .none
                cell.addSignatureValueDidChange = self
                cell.productLabel.text = "\("VALUE_FOR_SALE".localized()) - \((indexPath.row + 1) * 12) \(cell.productLabel.text!.localized())"
                self.addSignatureValueRequest?.signatureItems?.append(SignatureItemsRequest(monthCount: ((indexPath.row + 1) * 12), salesValue: 0.0))
            } else {
                cell.productViewModel = viewModel
                cell.valueDidChangeDelegate = self
                cell.selectionStyle = .none
            }
            return cell
        case .update:
            guard let viewModel = self.productToEditViewModel else {
                return UITableViewCell()
            }
            cell.productToEditViewModel = viewModel
            if viewModel.isSignature {
                cell.selectionStyle = .none
                cell.addSignatureValueDidChange = self
                cell.productLabel.text = "\("VALUE_FOR_SALE".localized()) - \((indexPath.row + 1) * 12) \(cell.productLabel.text!.localized())"
            } else {
                cell.valueDidChangeDelegate = self
                cell.selectionStyle = .none
            }
            return cell
        }
    }
}

extension AddProductViewController: AddValueAccountProductDidChangeDelegate {
    public func didChangeValueAccountProduct(with newValue: Double) {
        switch productActionManager {
        case .add:
            guard let product = productViewModel else { return }
            self.addValueAccountProductParameters = AddValueAccountProductRequest(productId: product.productId, salesValue: newValue)
        case .update:
            guard let product = productToEditViewModel else { return }
            self.updateValueAccountProductRequest = UpdateValueAccountProductRequest(salesValue: newValue)
            self.updateValueAccountProductPath = PathComponentRequest(path: "\(product.accountProductId)")
        }
    }
}

extension AddProductViewController: AddSignatureValueDidChange {
    public func didChangeSignatureValue(with newValue: Double, for index: Int) {
        switch productActionManager {
        case .add:
            self.addSignatureValueRequest?.signatureItems?[index].salesValue = newValue
        case .update:
            self.updateSignatureValueRequest?.signatureItems?[index].salesValue = newValue
        }
    }
}


extension AddProductViewController: ResultNoContentViewModel {
    public func result(_ viewModel: NoContentViewModel) {
        navigationController?.popViewController(animated: true)
    }
}

extension AddProductViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
//            activityIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
//            activityIndicator.stopAnimating()
        }
    }
}

extension AddProductViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title.localized(), message: viewModel.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
