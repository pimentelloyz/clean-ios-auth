import UIKit

class HeaderPrimary: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        font = MainFont.bold.with(size: Responsive.of().ip(3.8).inch)
        textColor = Color.textPrimary
        text = text?.localized()
    }
}
