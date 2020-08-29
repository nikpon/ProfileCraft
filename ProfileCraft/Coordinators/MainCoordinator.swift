import UIKit

final class MainCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let greetingsViewController = GreetingsViewController()
        
        let greetingsCoordinator = GreetingsCoordinator(viewController: greetingsViewController)
        greetingsViewController.coordinator = greetingsCoordinator
        
        window.rootViewController = greetingsViewController
        window.makeKeyAndVisible()
    }
    
}
