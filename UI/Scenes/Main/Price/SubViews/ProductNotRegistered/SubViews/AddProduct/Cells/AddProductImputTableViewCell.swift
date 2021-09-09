import UIKit
import Presentation

public class AddProductImputTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: HeaderPrimary!
    @IBOutlet weak var productValeuTextField: UITextField!
    
    var valueDidChangeDelegate: AddValueAccountProductDidChangeDelegate?
    var addSignatureValueDidChange: AddSignatureValueDidChange?
    public var productActionManager: ProductActionManager = ProductActionManager.add
    
    var productViewModel: LoadProductNotRegisteredByAccountBodyViewModel?
    var productToEditViewModel: LoadProductRegisteredByAccountBodyViewModel? {
        didSet {
            updateUI()
        }
    }
    
    var indexPath: IndexPath!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        productValeuTextField.delegate = self
    }
    
    func updateUI() {
        switch productActionManager {
        case .add:
            break
        case .update:
            guard let viewModel = productToEditViewModel else {
                return
            }
            if viewModel.isSignature {
                productValeuTextField.text  = "\(viewModel.signatures?[indexPath.row].salesValue ?? 0.0)"
            } else {
                productValeuTextField.text  = "\(viewModel.salesValeu)"
            }
        }
    }
}

extension AddProductImputTableViewCell: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let safeText = textField.text else { return }
        guard let newValue = Double(safeText) else { return }
        
        switch productActionManager {
        case .add:
            guard let viewModel = productViewModel else { return }
            if viewModel.isSignature {
                self.addSignatureValueDidChange?.didChangeSignatureValue(with: newValue, for: indexPath.row)
            } else {
                self.valueDidChangeDelegate?.didChangeValueAccountProduct(with: newValue)
            }
        case .update:
            guard let viewModel = productToEditViewModel else {
                return
            }
            if viewModel.isSignature {
                self.addSignatureValueDidChange?.didChangeSignatureValue(with: newValue, for: indexPath.row)
            } else {
                self.valueDidChangeDelegate?.didChangeValueAccountProduct(with: newValue)
            }
        }
    }
}
