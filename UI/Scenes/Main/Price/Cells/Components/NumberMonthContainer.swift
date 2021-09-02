import UIKit

class NumberMonthContainer: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        backgroundColor = Color.customGray
        clipsToBounds = true
        layer.cornerRadius = 3
    }
}
