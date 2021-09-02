import UIKit

class CancelButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        setTitle(titleLabel?.text?.localized(), for: .normal)
        backgroundColor = Color.clear
        setTitleColor(Color.textPrimary, for: .normal)
        titleLabel?.font = MainFont.semiBold.with(size: Responsive.of().ip(2.1).inch)
    }
}
