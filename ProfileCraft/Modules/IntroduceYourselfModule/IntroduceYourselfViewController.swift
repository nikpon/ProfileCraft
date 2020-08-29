import UIKit

final class IntroduceYourselfViewController: UIViewController {
    
    // MARK: - Properties
    var coordinator: IntroduceYourselfCoordinator?
    
    private var introduceYourselfView: IntroduceYourselfView {
        return view as! IntroduceYourselfView
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let introduceYourselfView = IntroduceYourselfView()
        introduceYourselfView.delegate = self
        introduceYourselfView.nameTextField.delegate = self
        view = introduceYourselfView
    }
    
}

// MARK: - IntroduceYourselfViewDelegate
extension IntroduceYourselfViewController: IntroduceYourselfViewDelegate {
    
    func backButtonTapped() {
        coordinator?.finishIntroducing()
    }
    
    func datePickerValueChanged(_ dateString: String) {
        
    }
    
    func nextButtonTapped() {
        coordinator?.addProfilePhoto()
    }
    
}

// MARK: - UITextFieldDelegate
extension IntroduceYourselfViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        introduceYourselfView.nameTextFieldResignFirstResponder()
        return true
    }
    
}
