import UIKit

typealias MainFont = Font.MontSerrat

enum Font {
    enum MontSerrat: String {
        case medium = "Medium"
        case light = "Light"
        case bold = "Bold"
        case semiBold = "SemiBold"
        case thin = "Thin"
        case black = "Black"
        case regular = "Regular"
        
        func with(size: CGFloat) -> UIFont {
            return UIFont(name: "Montserrat-\(rawValue)", size: size) ?? UIFont.systemFont(ofSize: 16)
        }
    }
}
