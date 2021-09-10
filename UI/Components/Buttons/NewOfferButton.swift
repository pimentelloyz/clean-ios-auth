import UIKit

class NewOfferButton: UIButton {
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
        backgroundColor = Color.customGray
        clipsToBounds = true
        layer.cornerRadius = heightResponsive / 2.1
        setTitleColor(Color.textGray, for: .normal)
        titleLabel?.font = MainFont.bold.with(size: Responsive.of().ip(2.1).inch)
    }
}
