import UIKit

public class AddProductImputTableViewCell: UITableViewCell {

    @IBOutlet weak var productLabel: HeaderPrimary!
    @IBOutlet weak var productValeuTextField: UITextField!
    
    var valueDidChangeDelegate: AddValueAccountProductDidChangeDelegate?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        productValeuTextField.delegate = self
    }
}

extension AddProductImputTableViewCell: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        guard let safeText = textField.text else { return }
        guard let newValue = Double(safeText) else { return }
        self.valueDidChangeDelegate?.didChangeValueAccountProduct(with: newValue)
    }
}
