import UIKit

class BoldLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        font = MainFont.bold.with(size: Responsive.of().ip(2).inch)
        textColor = Color.textBlack
        text = text?.localized()
    }
}
