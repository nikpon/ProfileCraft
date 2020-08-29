import UIKit

final class GreetingsViewController: UIViewController {
    
    // MARK: - Properties
    var coordinator: GreetingsCoordinator?
    
    private var greetingsView: GreetingsView {
        return view as! GreetingsView
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let greetingsView = GreetingsView()
        greetingsView.delegate = self
        view = greetingsView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension GreetingsViewController: GreetingsViewDelegate {
    
    func letsGoButtonTapped() {
        coordinator?.verifyPhone()
    }
    
    func circleButtonTapped() {
        print("circleButtonTapped")
    }
    
    func safariButtonTapped() {
        print("safariButtonTapped")
    }
    
    func homeButtonTapped() {
        print("homeButtonTapped")
    }
    
}
