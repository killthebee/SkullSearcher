protocol LoginViewModelProtocol: AnyObject {
    var showEmailWarning: (() -> ())? { get set }
    var hideEmailWarning: (() -> ())? { get set }
    func handleEmailInput(_ input: String?)
}

class LoginViewModel: LoginViewModelProtocol {
    
    let verifierService = verifier.shared
    weak var coordinatorDelegate: LoginCoordinatorProtocol?
    
    var showEmailWarning: (() -> ())?
    var hideEmailWarning: (() -> ())?
    
    func handleEmailInput(_ input: String?) {
        if input == nil || !verifierService.isValidEmail(input) {
            showEmailWarning?()
            return
        }
        coordinatorDelegate?.presentConfirmScreen(input)
    }
}
