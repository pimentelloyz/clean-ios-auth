import UIKit
import Presentation

public final class ProductSignatureTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: BoldLabel!
    @IBOutlet weak var lastPurchasePrice: RegularLabel!
    @IBOutlet var monthLabel: [TextLabelPrimary]!
    @IBOutlet var productPriceCollectionLabel: [TextLabelPrimary]!
    @IBOutlet var monthCountLabel: [TextLabelPrimary]!
    
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
        lastPurchasePrice.text  = viewModel.lastPurchesePriceString.localized() + " " + viewModel.lastPurchasePrice.currencyInputFormatting()
        for (index, label) in monthLabel.enumerated() {
            label.text = label.text?.localized()
            monthCountLabel[index].text = "\((index + 1) * 12)"
        }
        
        guard let signatures = viewModel.signatures else { return }
        for (index, signature) in signatures.enumerated() {
            productPriceCollectionLabel[index].text = "\(signature.salesValue)".currencyInputFormatting()
        }
    }
}
