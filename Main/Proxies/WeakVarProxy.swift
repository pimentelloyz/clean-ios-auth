import Foundation
import Presentation

class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}

extension WeakVarProxy: LocalCurrentAccountResultViewModel where T: LocalCurrentAccountResultViewModel {
    func result(_ viewModel: LocalCurrentAccounViewModel) {
        instance?.result(viewModel)
    }
}

extension WeakVarProxy: AuthenticationResultViewModel where T: AuthenticationResultViewModel {
    func result(_ viewModel: AuthenticationViewModel) {
        instance?.result(viewModel)
    }
}

extension WeakVarProxy: GenerateTokenResultViewModel where T: GenerateTokenResultViewModel {
    func result(_ viewModel: GenerateTokenViewModel) {
        instance?.result(viewModel)
    }
}

extension WeakVarProxy: LoadProductRegisteredByAccountResultViewModel where T: LoadProductRegisteredByAccountResultViewModel {
    func result(_ viewModel: LoadProductRegisteredByAccountViewModel) {
        instance?.result(viewModel)
    }
}
