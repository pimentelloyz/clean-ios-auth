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
    var indexPath: IndexPath!
    var showMenuDelegate: ProductOptionsDidTapDelegate?
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI() {
        guard let viewModel = product else { return }
        productNameLabel.text   = viewModel.codeAndNameProduct
        if let value = viewModel.body?.salesValue {
            productPriceLabel.text  = "\(value)".currencyInputFormatting()
        } else {
            productPriceLabel.text = "NO_PRICE".localized()
        }
       

        lastPurchasePrice.text  = viewModel.lastPurchesePriceString.localized() + " " + viewModel.lastPurchasePrice.currencyInputFormatting()
    }
    
    @IBAction func optionsDidTap(_ sender: Any) {
        showMenuDelegate?.showMenu(by: indexPath)
    }
}
