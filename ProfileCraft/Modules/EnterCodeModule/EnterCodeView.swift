import UIKit

protocol EnterCodeViewDelegate: AnyObject {
    func backButtonTapped()
    func resendCodeButtonTapped()
}

final class EnterCodeView: UIView {
    
    // MARK: - Properties
    private let backButton = PCButton(image: UIImage(named: "back"))
    
    private let mainLabel = PCLabel(
        mutableAttributedText: NSMutableAttributedString(string: "Next, enter the code\nwe sent "),
        imageAttachment: UIImage(named:"emoji4"),
        font: .compactRounded(style: .bold, size: 30),
        textColor: .black,
        textAlignment: .left
    )
    
    private let additionalLabel = PCLabel(text: "VERIFICATION CODE", font: .compactRounded(style: .semibold, size: 15), textColor: .darkGray, textAlignment: .left)
    
    let resendCodeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.compactRounded(style: .semibold, size: 15)
        button.addTarget(self, action: #selector(resendCodeButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let pinCodeView = PinCodeView()
    
    weak var delegate: EnterCodeViewDelegate?
    
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
        addSubviews(backButton, mainLabel, additionalLabel, pinCodeView, resendCodeButton)
        
        setupBackButton()
        setupMainLabel()
        setupAdditionalLabel()
        setupPinCodeView()
        setupResendCodeButton()
    }
    
    func setResendCodeButton(isEnabled: Bool, title: String) {
        self.resendCodeButton.isEnabled = isEnabled
        self.resendCodeButton.setTitle(title, for: .normal)
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc private func resendCodeButtonTapped() {
        delegate?.resendCodeButtonTapped()
    }
    
}

// MARK: - Setup Views
private extension EnterCodeView {
    
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
    
    func setupPinCodeView() {
        pinCodeView.anchor(top: additionalLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 25, paddingTrailing: 25, height: 45)
    }
    
    func setupResendCodeButton() {
        resendCodeButton.anchor(height: 20)
        resendCodeButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resendCodeButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 80).isActive = true
    }
    
}
