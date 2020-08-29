import UIKit

final class PinCellView: UIView {
    
    // MARK: - Properties
    let phoneDigitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRounded(style: .semibold, size: 17)
        
        return label
    }()
    
    let circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        
        return view
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func commonInit() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 15
        
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(circleView, phoneDigitLabel)
        
        setupCircleView()
        setupPhoneDigitLabel()
    }
    
}

// MARK: - Setup Views
private extension PinCellView {
    
    func setupCircleView() {
        circleView.anchor(width: 12, height: 12)
        circleView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circleView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupPhoneDigitLabel() {
        phoneDigitLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneDigitLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        phoneDigitLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
