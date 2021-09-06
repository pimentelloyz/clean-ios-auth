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
    
    public var productViewModel: LoadProductNotRegisteredByAccountBodyViewModel?
    public var productToEditViewModel: LoadProductRegisteredByAccountBodyViewModel?
    
    public var addValueAccountProduct: ((AddValueAccountProductRequest) -> Void)?
    var addValueAccountProductParameters: AddValueAccountProductRequest?
    public var updateValueAccountProduct: ((UpdateValueAccountProductRequest, PathComponentRequest) -> Void)?
    var aupdateValueAccountProductParameters: UpdateValueAccountProductRequest?
    
    public var addSignatureValue: ((AddSignatureValueRequest) -> Void)?
    var addSignatureValueRequest: AddSignatureValueRequest?
    
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
        guard let product = productViewModel else { return }
        productNameLabel.text = product.codeAndNameProduct
        monthsCountLabel.text = product.isSignature ? product.signatureOptions.localized() : ""
        if product.isSignature {
            addSignatureValueRequest = AddSignatureValueRequest(productId: product.productId, signatureItems: [])
        }
    }
    
    @IBAction func closeDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveProductDidTap(_ sender: Any) {
        guard let viewModel = productViewModel else { return }
        if viewModel.isSignature {
            guard let parameters = addSignatureValueRequest else { return }
            addSignatureValue?(parameters)
        } else {
            guard let parameters = addValueAccountProductParameters else { return }
            addValueAccountProduct?(parameters)
        }
    }
}

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel?.numberOfRowsOnAddProductView() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.addProductImputTableViewCell, for: indexPath) as! AddProductImputTableViewCell
        guard let viewModel = self.productViewModel else {
            return UITableViewCell()
        }
        
        if viewModel.isSignature {
            cell.productViewModel = viewModel
            cell.indexPath = indexPath
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
    }
}

extension AddProductViewController: AddValueAccountProductDidChangeDelegate {
    public func didChangeValueAccountProduct(with newValue: Double) {
        guard let product = productViewModel else { return }
        self.addValueAccountProductParameters = AddValueAccountProductRequest(productId: product.productId, salesValue: newValue)
    }
}

extension AddProductViewController: AddSignatureValueDidChange {
    public func didChangeSignatureValue(with newValue: Double, for index: Int) {
        self.addSignatureValueRequest?.signatureItems?[index].salesValue = newValue
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
