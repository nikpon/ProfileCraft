import UIKit

class EnterCodeViewController: UIViewController {
    
    // MARK: - Properties
    var coordinator: EnterCodeCoordinator?
    
    private var enterCodeView: EnterCodeView {
        return view as! EnterCodeView
    }
    
    var generatedCode: String!
    
    // MARK: - View Life Cycle
    override func loadView() {
        let enterCodeView = EnterCodeView()
        enterCodeView.delegate = self
        
        view = enterCodeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    // MARK: - Methods
    private func commonInit() {
        changeResendState()
        configurePinCodeView()
    }
    
    private func configurePinCodeView() {
        let pinCodeView = enterCodeView.pinCodeView
        pinCodeView.firstResponder(toBecome: true)
        
        enterCodeView.pinCodeView.didFinishEnteringCode = { [weak self] code in
            guard let self = self else { return }
            
            if let generatedCode = self.generatedCode, generatedCode == code {
                pinCodeView.firstResponder(toBecome: false)
                self.showAlert(title: "Success", message: "Go to create your profile") {
                    self.coordinator?.introduceYourself()
                }
            } else {
                self.showAlert(title: "Error", message: "Bad server response") {
                    pinCodeView.emptyCodeString()
                }
            }
            
        }
    }
    
    private func changeResendState() {
        var startTime = 20
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            startTime -= 1
            self?.enterCodeView.setResendCodeButton(isEnabled: false, title: "Resend Code in \(startTime) sec")
            if startTime == 0 {
                self?.enterCodeView.setResendCodeButton(isEnabled: true, title: "Resend Code")
                timer.invalidate()
            }
        }
    }
    
}

// MARK: - EnterCodeViewDelegate
extension EnterCodeViewController: EnterCodeViewDelegate {
    
    func backButtonTapped() {
        coordinator?.finishEntering()
    }
    
    func resendCodeButtonTapped() {
        changeResendState()
        self.generatedCode = RandomCodeService.shared.generateRandomPinCode()
        if let generatedCode = generatedCode {
            showAlert(title: "Success", message: "Your code is \(generatedCode)")
        }
    }
    
}
