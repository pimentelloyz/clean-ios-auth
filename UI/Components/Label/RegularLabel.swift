import UIKit

class RegularLabel: UILabel {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        font = MainFont.regular.with(size: Responsive.of().ip(2).inch)
        textColor = Color.textGray
        text = text?.localized()
    }
}
