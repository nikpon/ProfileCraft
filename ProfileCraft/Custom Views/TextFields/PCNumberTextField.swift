import UIKit

class PCNumberTextField: UITextField {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(attributedPlaceholder: NSMutableAttributedString, textAlignment: NSTextAlignment, keyboardType: UIKeyboardType, font: UIFont?) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.keyboardType = keyboardType
        self.font = font
        self.attributedPlaceholder = attributedPlaceholder
    }
    
    // MARK: - Methods
    private func configure() {
        textContentType = .telephoneNumber
    }
    
}
