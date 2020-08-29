import UIKit

final class PinCodeView: UIView, UITextInputTraits {
    
    // MARK: - Properties
    private let stackView = UIStackView()
    
    var keyboardType: UIKeyboardType = .phonePad
    
    var didFinishEnteringCode: ((String) -> Void)?
    
    private var code: String = "" {
        didSet {
            updateStack(by: code)
            if code.count == maxLength, let didFinishEnteringCode = didFinishEnteringCode {
                didFinishEnteringCode(code)
            }
        }
    }
    
    private var maxLength = 6
    
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
        addSubviews(stackView)
        
        setupPinCellsStackView()
    }
    
    private func emptyPinCell() -> UIView {
        let pinCellView = PinCellView()
        pinCellView.circleView.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        
        return pinCellView
    }
    
    private func pin() -> UIView {
        let pinCellView = PinCellView()
        
        return pinCellView
    }
    
    private func updateStack(by code: String) {
        var emptyPins: [UIView] = Array(0..<maxLength).map{ _ in emptyPinCell() }
        let userPinLength = code.count
        let pins: [UIView] = Array(0..<userPinLength).map{ _ in pin() }
        
        for (index, element) in pins.enumerated() {
            emptyPins[index] = element
            if let stringIndex = code.index(code.startIndex, offsetBy: index, limitedBy: code.endIndex) {
                (element as? PinCellView)?.phoneDigitLabel.text = String(code[stringIndex])
            }
        }
        
        stackView.removeAllArrangedSubviews()
        
        for view in emptyPins {
            stackView.addArrangedSubview(view)
        }
    }
    
    func firstResponder(toBecome: Bool) {
        if toBecome {
            becomeFirstResponder()
        } else {
            resignFirstResponder()
        }
    }
    
    func emptyCodeString() {
        self.code = ""
    }
    
}

// MARK: - Setup Views
private extension PinCodeView {
    
    func setupPinCellsStackView() {
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 7
        updateStack(by: code)
    }
    
}

extension PinCodeView {
    override var canBecomeFirstResponder: Bool {
        return true
    }
}

// MARK: - UIKeyInput
extension PinCodeView: UIKeyInput {
    
    var hasText: Bool {
        return code.count > 0
    }
    
    func insertText(_ text: String) {
        if code.count == maxLength {
            return
        }
        code.append(contentsOf: text)
    }
    
    func deleteBackward() {
        if hasText {
            code.removeLast()
        }
    }
    
}
