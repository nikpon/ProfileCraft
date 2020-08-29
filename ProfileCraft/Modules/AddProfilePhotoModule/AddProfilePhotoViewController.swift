import UIKit

class AddProfilePhotoViewController: UIViewController {
    
    // MARK: - Properties
    var coordinator: AddProfilePhotoCoordinator?
    
    private var addProfilePhotoView: AddProfilePhotoView {
        return view as! AddProfilePhotoView
    }
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        return imagePicker
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let addProfilePhotoView = AddProfilePhotoView()
        addProfilePhotoView.delegate = self
        view = addProfilePhotoView
    }
    
}

// MARK: - AddProfilePhotoViewDelegate
extension AddProfilePhotoViewController: AddProfilePhotoViewDelegate {
    
    func backButtonTapped() {
        coordinator?.finishAddingProfile()
    }
    
    func editButtonTapped() {
        imagePicker.present(imageIsEmpty: false)
    }
    
    func skipButtonTapped() {
        
    }
    
    func addPhotoButtonTapped(state: AddButtonState) {
        switch state {
        case .add:
            imagePicker.present()
        case .done:
            break
        }
    }
    
}

// MARK: - ImagePickerDelegate
extension AddProfilePhotoViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        addProfilePhotoView.setProfileImage(image)
    }
    
}
