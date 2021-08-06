import UIKit

class GoogleButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        let heightResponsive = Responsive.of().hp(6.2).height ?? 18
        setHeight(heightResponsive)
        backgroundColor = Color.white
        clipsToBounds = true
        layer.cornerRadius = heightResponsive / 2
        layer.borderWidth = 1
        layer.borderColor = Color.textPrimary.cgColor
        setTitleColor(Color.textPrimary, for: .normal)
        titleLabel?.font = MainFont.bold.with(size: Responsive.of().ip(2).inch)
        setTitle(titleLabel?.text?.localized(), for: .normal)
    }
}
