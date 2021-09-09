import UIKit

class FacebookButton: UIButton {
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
        setTitle(titleLabel?.text?.localized(), for: .normal)
        backgroundColor = Color.primary
        clipsToBounds = true
        layer.cornerRadius = heightResponsive / 2
        setTitleColor(Color.white, for: .normal)
        titleLabel?.font = MainFont.semiBold.with(size: Responsive.of().ip(1.8).inch)
    }
}
