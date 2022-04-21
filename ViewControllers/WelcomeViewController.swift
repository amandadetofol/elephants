import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    var welcomeView = WelcomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup(){
        welcomeView.delegate = self
        self.view = welcomeView
    }
    
}

extension WelcomeViewController: WelcomeViewDelegate {
    func handleLetsGetStartedButtonTap() {
        self.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
}
