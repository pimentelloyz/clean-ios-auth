import UIKit
import Presentation

public final class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: BoldLabel!
    @IBOutlet weak var productPriceLabel: TextLabelPrimary!
    @IBOutlet weak var lastPurchasePrice: RegularLabel!
    
    var product: LoadProductRegisteredByAccountBodyViewModel? {
        didSet {
            updateUI()
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        guard let viewModel = product else { return }
        productNameLabel.text   = viewModel.productName
        productPriceLabel.text  = viewModel.salesValeu
        lastPurchasePrice.text  = (lastPurchasePrice.text?.localized())! +  viewModel.lastPurchasePrice
    }
}
