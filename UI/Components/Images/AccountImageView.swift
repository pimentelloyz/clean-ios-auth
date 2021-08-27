import UIKit

class AccountImageView: UIImageView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = layer.frame.width / 2
    }
}
