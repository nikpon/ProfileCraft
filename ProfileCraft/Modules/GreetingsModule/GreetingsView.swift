import UIKit

protocol GreetingsViewDelegate: AnyObject {
    func letsGoButtonTapped()
    func circleButtonTapped()
    func safariButtonTapped()
    func homeButtonTapped()
}

final class GreetingsView: UIView {
    
    // MARK: - Properties
    private let smileImageView = UIImageView(image: UIImage(named: "whiteSmile"))
    
    private let mainLabel = PCLabel(text: "Craft your profile", font: UIFont.compactRounded(style: .bold, size: 26), textColor: .white, textAlignment: .center)
    
    private let additionalLabel = PCLabel(text: "Create a profile, follow other\n acounts, make your own lives!", font: UIFont.compactRounded(style: .light, size: 20), textColor: .white, textAlignment: .center)
    
    private let letsGoButton = PCButton(backgroundColor: .white, title: "LET'S GO!!!", titleColor: .black, titleLabelFont: UIFont.compactRounded(style: .semibold, size: 19), cornerRadius: 20)
    
    private let termsAndPrivacyTextView = PCTermsAndPrivacyTextView(
        text: "By signing up, you agree to our Terms\n and Privacy Policy",
        wordsAndLinksDictionary: [
            "Terms": "https://developer.apple.com/terms/",
            "Privacy Policy": "https://www.apple.com/legal/privacy/en-ww/"
        ],
        textFont: UIFont.compactRounded(style: .medium, size: 16),
        linksTextFont: UIFont.compactRounded(style: UIFont.FontStyle.bold, size: 16),
        textColor: .white
    )
    
    let circleButton = PCButton(image: UIImage(named: "circle"), cornerRadius: 10)
    let safariButton = PCButton(image: UIImage(named: "safari"), cornerRadius: 10)
    let homeButton = PCButton(image: UIImage(named: "home"), cornerRadius: 10)
    
    weak var delegate: GreetingsViewDelegate?
    
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
        backgroundColor = .mainBlue
        setupViews()
    }
    
    private func addEmitterLayer() {
        let emojiImages = [UIImage(named: "emoji1"), UIImage(named: "emoji2"), UIImage(named: "emoji3"), UIImage(named: "emoji4"), UIImage(named: "emoji5")]
        let emitter = EmojiEmitterLayerAnimator(emojiImages: emojiImages)
        layer.addSublayer(emitter.createEmitterLayer())
    }
    
    private func setupViews() {
        addSubviews(smileImageView, mainLabel, additionalLabel, letsGoButton, termsAndPrivacyTextView)
        addEmitterLayer()
        addSubviews(circleButton, safariButton, homeButton)
        
        setupSmileImageView()
        setupLabels()
        setupLetsGoButton()
        setupBottomButtons()
        setupTermsAndPrivacyTextView()
    }
    
    // MARK: - Actions
    @objc private func letsGoButtonTapped() {
        delegate?.letsGoButtonTapped()
    }
    
    @objc private func circleButtonTapped() {
        delegate?.circleButtonTapped()
    }
    
    @objc private func safariButtonTapped() {
        delegate?.safariButtonTapped()
    }
    
    @objc private func homeButtonTapped() {
        delegate?.homeButtonTapped()
    }
    
}

// MARK: - Setup Views
private extension GreetingsView {
    
    func setupSmileImageView() {
        smileImageView.anchor(width: 80, height: 80)
        smileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        smileImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
    }
    
    func setupLabels() {
        mainLabel.anchor(top: smileImageView.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 15)
        additionalLabel.anchor(top: mainLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 10)
    }
    
    func setupLetsGoButton() {
        letsGoButton.anchor(top: additionalLabel.bottomAnchor, paddingTop: 30, width: 200, height: 45)
        letsGoButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        letsGoButton.addTarget(self, action: #selector(letsGoButtonTapped), for: .touchUpInside)
    }
    
    func setupBottomButtons() {
        circleButton.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 50, height: 50)
        circleButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -70).isActive = true
        circleButton.addTarget(self, action: #selector(circleButtonTapped), for: .touchUpInside)
        circleButton.alpha = 0.9
        
        homeButton.anchor(bottom: safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, width: 50, height: 50)
        homeButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 70).isActive = true
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        homeButton.alpha = 0.9
        
        safariButton.anchor(bottom: circleButton.topAnchor, paddingBottom: -30, width: 50, height: 50)
        safariButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        safariButton.addTarget(self, action: #selector(safariButtonTapped), for: .touchUpInside)
        safariButton.alpha = 0.9
    }
    
    func setupTermsAndPrivacyTextView() {
        termsAndPrivacyTextView.anchor(leading: leadingAnchor, bottom: safariButton.topAnchor, trailing: trailingAnchor, paddingBottom: 10)
    }
    
}
