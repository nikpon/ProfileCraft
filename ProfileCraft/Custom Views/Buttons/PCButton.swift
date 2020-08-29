import UIKit

class PCButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            animate(with: isHighlighted)
        }
    }
    var transformScale: CGFloat = 0.8
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(image: UIImage? = nil, backgroundColor: UIColor? = nil, title: String? = nil, titleColor: UIColor? = nil, titleLabelFont: UIFont? = nil, cornerRadius: CGFloat? = nil, transformScale: CGFloat = 0.8) {
        self.init(frame: .zero)
        
        setImage(image, for: .normal)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = titleLabelFont
        self.transformScale = transformScale
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK:- Methods
    private func animate(with value: Bool) {
        var transform = CGAffineTransform.identity
        
        if value {
            UIView.animate(withDuration: 0.2) {
                transform = CGAffineTransform(scaleX: self.transformScale, y: self.transformScale)
            }
        }
        
        UIView.animate(withDuration: 0.2) {
            self.transform = transform
        }
    }
    
}
