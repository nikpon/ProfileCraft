import UIKit

protocol VerifyingPhone: AnyObject {
    func verifyPhone()
}

final class GreetingsCoordinator: Coordinator, VerifyingPhone {
    
    let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func start() {
        let greetingsViewController = GreetingsViewController()
        greetingsViewController.coordinator = self
    }
    
    func verifyPhone() {
        let navigationController = UINavigationController()
        let verifyPhoneCoordinator = VerifyPhoneCoordinator(parentCoordinator: self, navigationController: navigationController)
        
        verifyPhoneCoordinator.start()
    }
    
}
