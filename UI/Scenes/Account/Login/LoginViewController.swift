import Foundation
import UIKit
import Presentation

public final class LoginViewController: UIViewController, Storyboarded, URLSessionDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signInWithFacebbokButton: UIButton!
    @IBOutlet weak var signInWithMicrosoftButton: UIButton!
    @IBOutlet weak var signInWithGoogleButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var keyboardNotification: NSNotification?
    var activeField: UITextField?
    
    public var signInWithFacebook: (() -> Void)?
    public var signInWithGoogle: (() -> Void)?
    public var signInWithMicrosoft: (() -> Void)?
    public var generateToken: ((GenerateTokenRequest) -> Void)?
    public var goToMain: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerForKeyboardNotifications()
    }
   
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configure() {
        signInWithFacebbokButton?.addTarget(self, action: #selector(signInWithFacebookTapped), for: .touchUpInside)
        signInWithMicrosoftButton?.addTarget(self, action: #selector(signInWithMicrosoftTapped), for: .touchUpInside)
        signInWithGoogleButton?.addTarget(self, action: #selector(signInWithGoogleTapped), for: .touchUpInside)
        hideKeyboradOnTap()
    }
    
    @objc private func signInWithFacebookTapped() {
        signInWithFacebook?()
    }
    
    @objc private func signInWithMicrosoftTapped() {
        signInWithMicrosoft?()
    }

    @objc private func signInWithGoogleTapped() {
        signInWithGoogle?()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deregisterFromKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(notification: NSNotification) {
        self.keyboardNotification = notification
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
        let contentInsets : UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: (keyboardSize!.height + 10.0), right: 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        var aRect : CGRect = UIScreen.main.bounds
        aRect.size.height -= keyboardSize!.height
        if activeField != nil {
            if (!aRect.contains(activeField!.frame.origin)) {
                self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
            }
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets : UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func generateTokenHandler(authentication: AuthenticationViewModel) {
        let request = GenerateTokenRequest(email: authentication.account?.email)
        generateToken?(request)
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
}

extension LoginViewController: AuthenticationResultViewModel {
    public func result(_ viewModel: AuthenticationViewModel) {
        generateTokenHandler(authentication: viewModel)
    }
}

extension LoginViewController: GenerateTokenResultViewModel {
    public func result(_ viewModel: GenerateTokenViewModel) {
        if viewModel.isLogged {
            goToMain?()
        }
    }
}

extension LoginViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            activityIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            activityIndicator.stopAnimating()
        }
    }
}

extension LoginViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title.localized(), message: viewModel.message.localized(), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
