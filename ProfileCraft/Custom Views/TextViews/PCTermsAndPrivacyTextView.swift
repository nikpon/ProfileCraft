import UIKit

class PCTermsAndPrivacyTextView: UITextView {
    
    // MARK:- Properties
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, wordsAndLinksDictionary: [String: String]?, textFont: UIFont?, linksTextFont: UIFont?, textColor: UIColor) {
        self.init(frame: .zero)
        
        let attributedText = NSMutableAttributedString(
            string: text, attributes: [
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.font: textFont as Any
            ]
        )
        if let wordsAndLinksDictionary = wordsAndLinksDictionary {
            for (key, value) in wordsAndLinksDictionary {
                let range = (text as NSString).range(of: key)
                attributedText.addAttribute(.link, value: value, range: range)
                attributedText.addAttribute(.font, value: linksTextFont as Any, range: range)
            }
        }
        
        let linkAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        self.linkTextAttributes = linkAttributes
        self.attributedText = attributedText
        self.textAlignment = .center
    }
    
    // MARK:- Methods
    private func configure() {
        backgroundColor = .clear
        isEditable = false
        isScrollEnabled = false
        isSelectable = true
    }
    
}
