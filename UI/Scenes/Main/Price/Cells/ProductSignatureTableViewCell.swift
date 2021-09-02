import UIKit
import Presentation

public final class ProductSignatureTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: BoldLabel!
    @IBOutlet weak var lastPurchasePrice: RegularLabel!
    @IBOutlet var monthLabel: [TextLabelPrimary]!
    @IBOutlet var productPriceCollectionLabel: [TextLabelPrimary]!
    
    
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
        productNameLabel.text   = viewModel.codeAndNameProduct
        lastPurchasePrice.text  = (lastPurchasePrice.text?.localized())! +  viewModel.lastPurchasePrice
        for (_, label) in monthLabel.enumerated() {
            label.text = label.text?.localized()
        }
        
        guard let signatures = viewModel.signatures else { return }
        for (index, signature) in signatures.enumerated() {
            productPriceCollectionLabel[index].text = "\(signature.salesValue)"
        }
    }
}
