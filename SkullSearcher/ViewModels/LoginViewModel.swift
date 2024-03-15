protocol LoginViewModelProtocol: AnyObject {
    var showEmailWarning: (() -> ())? { get set }
    var hideEmailWarning: (() -> ())? { get set }
    func handleEmailInput(_ input: String?)
}

class LoginViewModel: LoginViewModelProtocol {
    
    let verifier = Verifier.shared
    
    var showEmailWarning: (() -> ())?
    var hideEmailWarning: (() -> ())?
    
    func handleEmailInput(_ input: String?) {
        if input == nil || !verifier.isValidEmail(input) {
            showEmailWarning?()
        }
    }
}