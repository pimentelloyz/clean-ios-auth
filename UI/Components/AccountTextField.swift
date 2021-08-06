import UIKit

class AccountTextField: UITextField {
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
        font = MainFont.regular.with(size: Responsive.of().ip(2).inch)
        setHeight(Responsive.of().hp(6).height)
        tintColor = Color.textPrimary
    }
}
