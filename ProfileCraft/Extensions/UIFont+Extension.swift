import UIKit

extension UIFont {
    
    enum FontStyle {
        case ultralight
        case black
        case thin
        case light
        case bold
        case semibold
        case heavy
        case medium
        case regular
    }
    
    static func compactRounded(style: FontStyle, size: CGFloat) -> UIFont? {
        return UIFont.init(name: "SFCompactRounded-\("\(style)".capitalized)", size: size)
    }
    
}
