import UIKit

class SearchTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        backgroundColor = Color.clear
        layer.cornerRadius = 8
        let spacer = UIView()
        spacer.setDimensions(height: CGFloat(4), width: CGFloat(6))
        self.leftView = spacer
        self.leftViewMode = .always
        self.rightView = spacer
        self.rightViewMode = .always
        self.placeholder = placeholder?.localized()
        font = MainFont.regular.with(size: Responsive.of().ip(2).inch)
        tintColor = Color.textPrimary
    }
}
