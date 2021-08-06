import UIKit

class TextLabelPrimary: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        font = MainFont.semiBold.with(size: Responsive.of().ip(2).inch)
        textColor = Color.textPrimary
        text = text?.localized()
    }
}
