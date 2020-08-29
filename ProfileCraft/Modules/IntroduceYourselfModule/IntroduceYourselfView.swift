import UIKit

protocol IntroduceYourselfViewDelegate: AnyObject {
    func backButtonTapped()
    func datePickerValueChanged(_ dateString: String)
    func nextButtonTapped()
}

final class IntroduceYourselfView: UIView {
    
    // MARK: - Properties
    private let backButton = PCButton(image: UIImage(named: "back"))
    
    private let mainLabel = PCLabel(
        mutableAttributedText: NSMutableAttributedString(string: "Introduce yourself "),
        imageAttachment: UIImage(named:"emoji2"),
        font: UIFont.compactRounded(style: .bold, size: 30),
        textColor: .black,
        textAlignment: .left
    )
    
    private let nameLabel = PCLabel(text: "NAME", font: UIFont.compactRounded(style: .semibold, size: 15), textColor: UIColor.darkGray, textAlignment: .left)
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.compactRounded(style: .semibold, size: 17)
        textField.layer.cornerRadius = 15
        textField.setLeftPaddingPoints(10)
        textField.tintColor = .systemGray3
        textField.returnKeyType = .continue
        textField.autocorrectionType = .no
        textField.addTarget(self, action: #selector(nameTextFieldValueChanged), for: .editingChanged)
        
        return textField
    }()
    
    private let birthdayNameLabel = PCLabel(text: "BIRTHDAY", font: UIFont.compactRounded(style: .semibold, size: 15), textColor: .darkGray, textAlignment: .left)
    
    private let birthdayButton = PCTitleImageButton(
        rexonaImageView: UIImageView(image: UIImage(named: "rexona")),
        backgroundColor: .systemGray6,
        cornerRadius: 17,
        contentHorizontalAlignment: .left,
        transformScale: 0.95
    )
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .black
        label.font = UIFont.compactRounded(style: .semibold, size: 17)
        label.textAlignment = .left
        
        return label
    }()
    
    let birthdayPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(birthdayPickerValueChanged), for: .valueChanged)
        datePicker.maximumDate = Date()
        
        return datePicker
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
    
    var nameTextFieldHasText: Bool {
        return (nameTextField.text ?? "").count > 0
    }
    
    weak var delegate: IntroduceYourselfViewDelegate?
    
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
        nameTextField.becomeFirstResponder()
    }
    
    private func setupViews() {
        addSubviews(backButton, mainLabel, nameLabel, nameTextField, birthdayNameLabel, birthdayButton, birthdayLabel, birthdayPicker, nextButton)
        
        setupBackButton()
        setupMainLabel()
        setupNameLabel()
        setupNameTextField()
        setupBirthdayNameLabel()
        setupBirthdayButton()
        setupBirthdayLabel()
        setupBirthdayPicker()
        setupNextButton()
    }
    
    func nameTextFieldResignFirstResponder() {
        nameTextField.resignFirstResponder()
    }
    
    func enableNextButton(_ isEnabled: Bool, alpha: CGFloat) {
        nextButton.alpha = alpha
        nextButton.isEnabled = isEnabled
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        delegate?.backButtonTapped()
    }
    
    @objc private func nameTextFieldValueChanged() {
        if nameTextFieldHasText && birthdayLabel.text != nil {
            enableNextButton(true, alpha: 1.0)
        } else {
            enableNextButton(false, alpha: 0.5)
        }
    }
    
    @objc private func birthdayPickerValueChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: birthdayPicker.date)
//        birthdayButton.setTitle(dateString, for: .normal)
        birthdayLabel.text = dateString
        delegate?.datePickerValueChanged(dateString)

        if nameTextFieldHasText {
            enableNextButton(true, alpha: 1.0)
        }
    }
    
    @objc private func birthdayButtonTapped() {
        nameTextFieldResignFirstResponder()
    }
    
    @objc private func nextButtonTapped() {
        delegate?.nextButtonTapped()
    }
    
}

// MARK: - Setup Views
private extension IntroduceYourselfView {
    
    func setupBackButton() {
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, paddingTop: 10, paddingLeading: 20, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setupMainLabel() {
        mainLabel.anchor(top: backButton.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 20, paddingLeading: 25, height: 50)
    }
    
    func setupNameLabel() {
        nameLabel.anchor(top: mainLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 5, paddingLeading: 25, height: 40)
    }
    
    func setupNameTextField() {
        nameTextField.anchor(top: nameLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingLeading: 25, paddingTrailing: 25, height: 45)
    }
    
    func setupBirthdayNameLabel() {
        birthdayNameLabel.anchor(top: nameTextField.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 15, paddingLeading: 25, height: 40)
    }
    
    func setupBirthdayButton() {
        birthdayButton.anchor(top: birthdayNameLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingLeading: 25, paddingTrailing: 25, height: 45)
        birthdayButton.addTarget(self, action: #selector(birthdayButtonTapped), for: .touchUpInside)
    }
    
    func setupBirthdayLabel() {
        birthdayLabel.anchor(top: birthdayButton.topAnchor, leading: birthdayButton.leadingAnchor, bottom: birthdayButton.bottomAnchor, trailing: birthdayButton.trailingAnchor, paddingLeading: 10, paddingTrailing: 40)
    }

    
    func setupBirthdayPicker() {
        birthdayPicker.anchor(leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor)
    }
    
    func setupNextButton() {
        nextButton.anchor(top: birthdayButton.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 50, paddingLeading: 25, paddingTrailing: 25, height: 45)
        enableNextButton(false, alpha: 0.5)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
}
