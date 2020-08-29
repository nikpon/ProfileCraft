import UIKit

final class IntroduceYourselfCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let introduceYourselfViewController = IntroduceYourselfViewController()
        introduceYourselfViewController.coordinator = self
        
        navigationController?.pushViewController(introduceYourselfViewController, animated: true)
    }
    
    func addProfilePhoto() {
        let addProfilePhotoCoordinator = AddProfilePhotoCoordinator(navigationController: navigationController!)
        addProfilePhotoCoordinator.start()
    }
    
    func finishIntroducing() {
        navigationController?.popViewController(animated: true)
    }
    
}
