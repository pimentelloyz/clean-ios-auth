import UIKit
import Presentation

public class AddProductImputTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: HeaderPrimary!
    @IBOutlet weak var productValeuTextField: UITextField!
    
    var valueDidChangeDelegate: AddValueAccountProductDidChangeDelegate?
    var addSignatureValueDidChange: AddSignatureValueDidChange?
    
    var productViewModel: LoadProductNotRegisteredByAccountBodyViewModel? {
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
        guard let viewModel = productViewModel else { return }
    }
}

extension AddProductImputTableViewCell: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let safeText = textField.text else { return }
        guard let newValue = Double(safeText) else { return }
        guard let viewModel = productViewModel else { return }
        if viewModel.isSignature {
            self.addSignatureValueDidChange?.didChangeSignatureValue(with: newValue, for: indexPath.row)
        } else {
            self.valueDidChangeDelegate?.didChangeValueAccountProduct(with: newValue)
        }
    }
}
