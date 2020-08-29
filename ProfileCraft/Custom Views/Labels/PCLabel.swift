import UIKit

class PCLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String?, font: UIFont?, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.text = text
        commonInit(font: font, textColor: textColor, textAlignment: textAlignment, numberOfLines: 0)
    }
    
    convenience init(mutableAttributedText: NSMutableAttributedString, imageAttachment: UIImage?, font: UIFont?, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        commonInit(font: font, textColor: textColor, textAlignment: textAlignment, numberOfLines: 2)
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = imageAttachment
        
        let imageOffsetY: CGFloat = -5.0
        textAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 30, height: 30)
        
        let attachmentString = NSAttributedString(attachment: textAttachment)
        
        let completeText = mutableAttributedText
        completeText.append(attachmentString)
        
        attributedText = completeText
    }
    
    // MARK:- Methods
    private func commonInit(font: UIFont?, textColor: UIColor, textAlignment: NSTextAlignment, numberOfLines: Int) {
        self.font = font
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
    
    private func configure() {
        backgroundColor = .clear
    }
    
}
