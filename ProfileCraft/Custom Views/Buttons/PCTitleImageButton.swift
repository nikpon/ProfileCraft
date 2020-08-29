import UIKit

class PCTitleImageButton: PCButton {
    
    // MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(rexonaImageView: UIImageView? = nil, nextImageView: UIImageView? = nil, backgroundColor: UIColor? = nil, title: String? = nil, titleColor: UIColor? = nil, titleLabelFont: UIFont? = nil, cornerRadius: CGFloat? = nil, contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center, transformScale: CGFloat) {
        self.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.titleLabel?.font = titleLabelFont
        self.contentHorizontalAlignment = contentHorizontalAlignment
        self.transformScale = transformScale
        
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
        
        if let rexonaImageView = rexonaImageView {
            setupRexonaImageView(imageView: rexonaImageView)
        } else if let nextImageView = nextImageView {
            setupNextImageView(imageView: nextImageView)
        }
    }
    
    // MARK:- Methods
    private func setupRexonaImageView(imageView: UIImageView) {
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        addSubview(imageView)
        imageView.anchor(top: topAnchor, bottom: bottomAnchor, trailing: trailingAnchor, width: 40)
    }
    
    private func setupNextImageView(imageView: UIImageView) {
        addSubview(imageView)
        imageView.anchor(trailing: trailingAnchor, paddingTrailing: 10, width: 15, height: 15)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
