import UIKit

protocol CountryCodesCoordinatorDelegate: AnyObject {
    func finish(with countryCode: String)
}

final class CountryCodesCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    weak var delegate: CountryCodesCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let countryCodesViewController = CountryCodesViewController()
        let countryCodesNavigationController = UINavigationController(rootViewController: countryCodesViewController)
        countryCodesViewController.coordinator = self
        
        navigationController?.present(countryCodesNavigationController, animated: true, completion: nil)
    }
    
    func finish(with countryCode: String) {
        delegate?.finish(with: countryCode)
    }
    
}
