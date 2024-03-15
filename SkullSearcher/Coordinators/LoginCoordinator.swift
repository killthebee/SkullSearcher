protocol LoginCoordinatorProtocol: AnyObject {
    func presentConfirmScreen(_ email: String?)
}

class LoginCoordinator: Coordinator, LoginCoordinatorProtocol {
    
    weak var view: LoginViewController?
    
    func start() -> Presentable? {
        let loginVC = LoginViewController()
        let viewModel = LoginViewModel()
        viewModel.coordinatorDelegate = self
        loginVC.viewModel = viewModel
        self.view = loginVC
        
        return loginVC
    }
    
    func presentConfirmScreen(_ email: String?) {
        let confrimCoordinator = ConfirmCoordinator()
        confrimCoordinator.email = email
        guard
            let confirmVC = confrimCoordinator.start() as? ConfirmViewController
        else
            { return }
        confirmVC.modalPresentationStyle = .fullScreen
        // test@mail.ru
        view?.present(confirmVC)
    }
}
