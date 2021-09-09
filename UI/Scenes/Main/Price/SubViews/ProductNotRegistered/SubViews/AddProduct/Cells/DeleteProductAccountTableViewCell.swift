import UIKit

public final class DeleteProductAccountTableViewCell: UITableViewCell {

    var delegate: RemoveProductAccountDelegate?
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func removeDidTap(_ sender: Any) {
        delegate?.remove()
    }
}
