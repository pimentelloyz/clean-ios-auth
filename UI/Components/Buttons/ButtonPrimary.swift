import UIKit

class ButtonPrimary: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        let heightResponsive = Responsive.of().hp(7).height ?? 18
        setHeight(heightResponsive)
        setTitle(titleLabel?.text?.localized(), for: .normal)
        backgroundColor = Color.primary
        clipsToBounds = true
        layer.cornerRadius = heightResponsive / 3
        setTitleColor(Color.white, for: .normal)
        titleLabel?.font = MainFont.bold.with(size: Responsive.of().ip(2).inch)
    }
}
