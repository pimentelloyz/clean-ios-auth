import Presentation

class GenerateTokenResultViewModelSpy: GenerateTokenResultViewModel {
    var emit: ((GenerateTokenViewModel) -> Void)?
    
    func observe(competion: @escaping (GenerateTokenViewModel) -> Void) {
        self.emit = competion
    }
    
    func result(_ viewModel: GenerateTokenViewModel) {
        self.emit?(viewModel)
    }
}
