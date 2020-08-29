import UIKit

final class VerifyPhoneViewController: UIViewController {
    
    // MARK: - Properties
    var coordinator: VerifyPhoneCoordinator?
    
    private var verifyPhoneView: VerifyPhoneView {
        return view as! VerifyPhoneView
    }
    
    var countryCode: String?
    var generatedCode: String!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func loadView() {
        let verifyPhoneView = VerifyPhoneView()
        verifyPhoneView.delegate = self
        verifyPhoneView.phoneView.delegate = self
        
        view = verifyPhoneView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Methods
    private func commonInit() {
        if let countryCode = localeCountryCode() {
            setupCountryCode(with: countryCode)
        }
    }
    
    func setupCountryCode(with countryCode: String) {
        self.countryCode = countryCode
        verifyPhoneView.phoneView.countryButton.setTitle("+" + countryCode, for: .normal)
    }
    
    private func localeCountryCode() -> String? {
        guard
            let regionCode = Locale.current.regionCode,
            let countryName = Locale.current.localizedString(forRegionCode: regionCode),
            let countryCode = CountryCodeService.shared.getCurrentCountryCode(countryName: countryName)
            else { return nil }
        
        return countryCode
    }
    
}

// MARK: - VerifyPhoneViewDelegate
extension VerifyPhoneViewController: VerifyPhoneViewDelegate {
    
    func backButtonTapped() {
        coordinator?.finishVeryfying()
    }
    
    func nextButtonTapped() {
        generatedCode = RandomCodeService.shared.generateRandomPinCode()
        guard let generatedCode = generatedCode else { return }
        
        showAlert(title: "Success", message: "Your code is \(generatedCode)") { [weak self] in
            self?.coordinator?.enterCode()
        }
    }
}

// MARK: - PhoneViewDelegate
extension VerifyPhoneViewController: PhoneViewDelegate {
    
    func countryButtonTapped() {
        coordinator?.chooseCountryCode()
    }
    
    func phoneTextFieldValueChanged(with number: String) {
        guard let countryCode = countryCode else { return }
        verifyPhoneView.phoneView.changePhoneTextFieldText(with: PhoneNumberService.shared.formatPartial(number))
        
        if PhoneNumberService.shared.check(phoneNumber: countryCode + number) {
            verifyPhoneView.changeNextButtonAlpha(to: 1)
            verifyPhoneView.nextButton.isEnabled = true
        } else {
            verifyPhoneView.changeNextButtonAlpha(to: 0.5)
            verifyPhoneView.nextButton.isEnabled = false
        }
    }
    
}
