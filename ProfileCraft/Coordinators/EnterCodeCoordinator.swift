import UIKit

final class EnterCodeCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    var generatedCode: String!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let enterCodeViewController = EnterCodeViewController()
        enterCodeViewController.coordinator = self
        enterCodeViewController.generatedCode = self.generatedCode
        
        navigationController?.pushViewController(enterCodeViewController, animated: true)
    }
    
    func introduceYourself() {
        let introduceYourselfCoordinator = IntroduceYourselfCoordinator(navigationController: navigationController!)
        introduceYourselfCoordinator.start()
    }
    
    func finishEntering() {
        navigationController?.popViewController(animated: true)
    }
    
}
