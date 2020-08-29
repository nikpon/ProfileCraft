import UIKit

final class VerifyPhoneCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    var parentCoordinator: GreetingsCoordinator?
    weak var childCoordinator: CountryCodesCoordinator?
    weak var viewController: VerifyPhoneViewController?
    
    init(parentCoordinator: GreetingsCoordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let verifyPhoneViewController = VerifyPhoneViewController()
        verifyPhoneViewController.coordinator = self
        viewController = verifyPhoneViewController
        
        navigationController?.addChild(verifyPhoneViewController)
        navigationController?.navigationBar.isHidden = true
        navigationController?.modalPresentationStyle = .fullScreen
        
        parentCoordinator?.viewController.present(navigationController!, animated: true)
    }
    
    func finishVeryfying() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func enterCode() {
        let enterCodeCoordinator = EnterCodeCoordinator(navigationController: navigationController!)
        enterCodeCoordinator.generatedCode = viewController?.generatedCode
        enterCodeCoordinator.start()
    }
    
    func chooseCountryCode() {
        let countryCodesCoordinator = CountryCodesCoordinator(navigationController: navigationController!)
        countryCodesCoordinator.delegate = self
        childCoordinator = countryCodesCoordinator
        
        countryCodesCoordinator.start()
    }
    
}

// MARK:- BackwardValuePassingDelegate
extension VerifyPhoneCoordinator: CountryCodesCoordinatorDelegate {
    
    func finish(with countryCode: String) {
        viewController?.setupCountryCode(with: countryCode)
    }
    
}
