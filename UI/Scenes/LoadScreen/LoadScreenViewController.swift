import Foundation
import UIKit
import Presentation

public final class LoadScreenViewController: UIViewController, Storyboarded {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: LocalCurrentAccounViewModel? {
        didSet {
            navigateTo()
        }
    }
    
    public var checkAccount: (() -> Void)?
    public var goToLogin: (() -> Void)?
    public var goToMain: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        checkAccount?()
    }
    
    private func configure() {
        activityIndicator.startAnimating()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func navigateTo() {
        activityIndicator.stopAnimating()
        if viewModel?.account != nil {
            goToMain?()
        } else {
            goToLogin?()
        }
    }
}

extension LoadScreenViewController: LocalCurrentAccountResultViewModel {
    public func result(_ viewModel: LocalCurrentAccounViewModel) {
        self.viewModel = viewModel
    }
}
