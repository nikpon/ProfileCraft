import UIKit

final class AddProfilePhotoCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let addProfilePhotoViewController = AddProfilePhotoViewController()
        addProfilePhotoViewController.coordinator = self
        
        navigationController?.pushViewController(addProfilePhotoViewController, animated: true)
    }
    
    func finishAddingProfile() {
        navigationController?.popViewController(animated: true)
    }
    
}
