import Foundation
import UIKit

public final class OnboardingViewController: UIViewController, Storyboarded {
    @IBOutlet weak var getStartedButton: UIButton!
    
    public var login: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configure() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        getStartedButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        login?()
    }
}
