import UIKit

protocol PhoneViewDelegate: AnyObject {
    func countryButtonTapped()
    func phoneTextFieldValueChanged(with number: String)
}

final class PhoneView: UIView {
    
    // MARK: - Properties
    let countryButton = PCTitleImageButton(
        rexonaImageView: UIImageView(image: UIImage(named: "rexona")),
        backgroundColor: .clear,
        titleColor: .black,
        titleLabelFont: UIFont.compactRounded(style: .semibold, size: 17),
        cornerRadius: 17,
        contentHorizontalAlignment: .left,
        transformScale: 0.9
    )
    
    private let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        
        return view
    }()
    
    let phoneTextField = PCNumberTextField(
        attributedPlaceholder: NSMutableAttributedString(
            string: "Phone number",
            attributes: [NSAttributedString.Key.font: UIFont.compactRounded(style: .semibold, size: 17) as Any]
        ),
        textAlignment: .left,
        keyboardType: .numberPad,
        font: UIFont.compactRounded(style: .semibold, size: 17)
    )
    
    weak var delegate: PhoneViewDelegate?
    
    var phoneTextFieldText: String {
        return phoneTextField.text ?? ""
    }
    
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
        backgroundColor = .systemGray6
        layer.cornerRadius = 17
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(countryButton, verticalLineView, phoneTextField)
        
        setupCountryButton()
        setupVerticalLineView()
        setupPhoneTextField()
    }
    
    func changePhoneTextFieldText(with text: String) {
        phoneTextField.text = text
    }
    
    // MARK: - Actions
    @objc private func countryButtonTapped() {
        delegate?.countryButtonTapped()
    }
    
    @objc private func phoneTextFieldValueChanged() {
        delegate?.phoneTextFieldValueChanged(with: phoneTextFieldText)
    }
    
}

// MARK: - Setup Views
private extension PhoneView {
    
    func setupCountryButton() {
        countryButton.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, paddingLeading: 10, width: 90)
        countryButton.addTarget(self, action: #selector(countryButtonTapped), for: .touchUpInside)
    }
    
    func setupVerticalLineView() {
        verticalLineView.anchor(top: topAnchor, leading: countryButton.trailingAnchor, bottom: bottomAnchor, width: 1)
    }
    
    func setupPhoneTextField() {
        phoneTextField.anchor(top: topAnchor, leading: verticalLineView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingLeading: 10, paddingTrailing: 5)
        phoneTextField.addTarget(self, action: #selector(phoneTextFieldValueChanged), for: .editingChanged)
    }
    
}
