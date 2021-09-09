import UIKit
import Presentation

public class ProductNotRegisteredTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productNameLabel: BoldLabel!
    @IBOutlet weak var signatureOptionsLabel: RegularLabel!
    
    var product: LoadProductNotRegisteredByAccountBodyViewModel? {
        didSet {
            updateUI()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        guard let viewModel = product else { return }
        productNameLabel.text  = viewModel.codeAndNameProduct
        signatureOptionsLabel.text  = viewModel.isSignature ? (signatureOptionsLabel.text?.localized())! : ""
    }
}
