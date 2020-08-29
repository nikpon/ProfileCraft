import UIKit

protocol VerifyPhoneViewDelegate: AnyObject {
    func backButtonTapped()
    func nextButtonTapped()
}

final class VerifyPhoneView: UIView {
    
    // MARK: - Properties
    private let backButton = PCButton(image: UIImage(named: "cross"))
    
    private let mainLabel = PCLabel(
        mutableAttributedText: NSMutableAttributedString(string: "Let's verify your\nphone number "),
        imageAttachment: UIImage(named:"emoji1"),
        font: .compactRounded(style: .bold, size: 30),
        textColor: .black,
        textAlignment: .left
    )
    
    private let additionalLabel = PCLabel(text: "PHONE NUMBER", font: .compactRounded(style: .semibold, size: 15), textColor: .darkGray, textAlignment: .left)
    
    lazy var phoneView: PhoneView = {
        let view = PhoneView()
        
        return view
    }()
    
    let nextButton = PCTitleImageButton(
        nextImageView: UIImageView(image: UIImage(named: "next")),
        backgroundColor: .lightBlue,
        title: "Next",
        titleColor: .white,
        titleLabelFont: UIFont.compactRounded(style: .bold, size: 17),
        cornerRadius: 17,
        transformScale: 0.9
    )
    
    weak var delegate: VerifyPhoneViewDelegate?
    
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        addSubviews(backButton, mainLabel, additionalLabel, phoneView, nextButton)
        
        setupBackButton()
        setupMainLabel()
        setupAdditionalLabel()
        setupPhoneView()
        setupNextButton()
    }
    
    func changeNextButtonAlpha(to alpha: CGFloat) {
        nextButton.alpha = alpha
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.nextButtonTapped()
    }
    
}

// MARK: - Setup Views
private extension VerifyPhoneView {
    
    func setupBackButton() {
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, paddingTop: 10, paddingLeading: 20, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setupMainLabel() {
        mainLabel.anchor(top: backButton.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 25, height: 80)
    }
    
    func setupAdditionalLabel() {
        additionalLabel.anchor(top: mainLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 25, height: 20)
    }
    
    func setupPhoneView() {
        phoneView.anchor(top: additionalLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 10, paddingLeading: 25, paddingTrailing: 25, height: 45)
    }
    
    func setupNextButton() {
        nextButton.anchor(leading: leadingAnchor, trailing: trailingAnchor, paddingLeading: 25, paddingTrailing: 25, height: 45)
        nextButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50).isActive = true
        nextButton.alpha = 0.5
        nextButton.isEnabled = false
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
}
