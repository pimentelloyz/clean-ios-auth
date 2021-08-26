import UIKit

class ContainerCell: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        backgroundColor = Color.backgroundPrimary
        clipsToBounds = true
        layer.cornerRadius = 8
    }
}
