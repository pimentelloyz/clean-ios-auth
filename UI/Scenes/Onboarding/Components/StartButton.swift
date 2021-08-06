import Foundation
import UIKit

class StartButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        let heightResponsive = Responsive.of().hp(8).height ?? 18
        setHeight(heightResponsive)
        backgroundColor = Color.backgroundSeccoundary
        clipsToBounds = true
        layer.cornerRadius = heightResponsive / 2
        setTitleColor(Color.textPrimary, for: .normal)
        titleLabel?.font = MainFont.bold.with(size: Responsive.of().ip(2).inch)
        setTitle(titleLabel?.text?.localized(), for: .normal)
    }
}
