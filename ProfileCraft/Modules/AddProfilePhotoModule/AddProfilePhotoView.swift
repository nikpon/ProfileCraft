import UIKit

protocol AddProfilePhotoViewDelegate: AnyObject {
    func backButtonTapped()
    func skipButtonTapped()
    func editButtonTapped()
    func addPhotoButtonTapped(state: AddButtonState)
}

enum AddButtonState: String {
    case add = "Add Photo"
    case done = "Done"
}

final class AddProfilePhotoView: UIView {
    
    // MARK: - Properties
    private let backButton = PCButton(image: UIImage(named: "back"))
    
    private let mainLabel = PCLabel(
        mutableAttributedText: NSMutableAttributedString(string: "Add profile photo "),
        imageAttachment: UIImage(named:"emoji5"),
        font: UIFont.compactRounded(style: .bold, size: 30),
        textColor: .black,
        textAlignment: .left
    )
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 70
        imageView.image = UIImage(named: "addPhoto")
        
        return imageView
    }()
    
    private let editButton = PCButton(
        backgroundColor: UIColor.darkGray.withAlphaComponent(0.6),
        title: "Edit", titleColor: .white,
        titleLabelFont: UIFont.compactRounded(style: .bold, size: 17),
        cornerRadius: 10, transformScale: 0.95
    )
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip for now", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.compactRounded(style: .semibold, size: 14)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private let addPhotoButton = PCButton(
        backgroundColor: .lightBlue,
        title: AddButtonState.add.rawValue,
        titleColor: .white,
        titleLabelFont: UIFont.compactRounded(style: .bold, size: 17),
        cornerRadius: 17,
        transformScale: 0.9
    )
    
    private var buttonState: AddButtonState = .add {
        didSet {
            addPhotoButton.setTitle(buttonState.rawValue, for: .normal)
        }
    }
    
    weak var delegate: AddProfilePhotoViewDelegate?
    
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
        addSubviews(backButton, mainLabel, profileImageView, editButton, addPhotoButton, skipButton)
        
        setupBackButton()
        setupMainLabel()
        setupProfileImageView()
        setupEditButton()
        setupAddPhotoButton()
        setupSkipButton()
    }
    
    private func changeButtonState(to state: AddButtonState) {
        buttonState = state
    }
    
    private func configureEditAndSkipButtons(imageIsFilled: Bool) {
        if !imageIsFilled {
            editButton.isEnabled = false
            editButton.alpha = 0
            skipButton.alpha = 1
            skipButton.isEnabled = true
        } else {
            editButton.isEnabled = true
            editButton.alpha = 1
            skipButton.alpha = 0
            skipButton.isEnabled = false
        }
    }
    
    func setProfileImage(_ image: UIImage?) {
        if let image = image {
            profileImageView.image = image
            changeButtonState(to: .done)
            configureEditAndSkipButtons(imageIsFilled: true)
        } else {
            profileImageView.image = UIImage(named: "addPhoto")
            changeButtonState(to: .add)
            configureEditAndSkipButtons(imageIsFilled: false)
        }
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc private func skipButtonTapped() {
        delegate?.skipButtonTapped()
    }
    
    @objc private func addPhotoButtonTapped() {
        delegate?.addPhotoButtonTapped(state: buttonState)
    }
    
    @objc private func editButtonTapped() {
        delegate?.editButtonTapped()
    }
    
}

// MARK: - Setup Views
private extension AddProfilePhotoView {
    
    func setupBackButton() {
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, paddingTop: 10, paddingLeading: 20, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setupMainLabel() {
        mainLabel.anchor(top: backButton.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 25, height: 50)
    }
    
    func setupProfileImageView() {
        profileImageView.anchor(width: 170, height: 170)
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func setupEditButton() {
        editButton.anchor(bottom: profileImageView.bottomAnchor, paddingBottom: 10, width: 50, height: 30)
        editButton.centerXAnchor.constraint(greaterThanOrEqualTo: centerXAnchor).isActive = true
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        editButton.isEnabled = false
        editButton.alpha = 0
    }
    
    func setupAddPhotoButton() {
        addPhotoButton.anchor(leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, paddingLeading: 25, paddingBottom: 30, paddingTrailing: 25, height: 45)
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTapped), for: .touchUpInside)
    }
    
    func setupSkipButton() {
        skipButton.anchor(bottom: addPhotoButton.topAnchor, paddingBottom: 20, width: 80, height: 15)
        skipButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}
