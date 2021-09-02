import UIKit

class SaveButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        setTitle(titleLabel?.text?.localized(), for: .normal)
        backgroundColor = Color.primary
        clipsToBounds = true
        layer.cornerRadius = 26
        setTitleColor(Color.white, for: .normal)
        titleLabel?.font = MainFont.semiBold.with(size: Responsive.of().ip(2.1).inch)
    }
}
