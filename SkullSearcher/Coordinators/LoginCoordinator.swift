protocol LoginCoordinatorProtocol: AnyObject {
    func presentConfirmScreen()
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
    
    func presentConfirmScreen() {
        let confrimCoordinator = ConfirmCoordinator()
        guard
            let confirmVC = confrimCoordinator.start() as? ConfirmViewController
        else
            { return }
        confirmVC.modalPresentationStyle = .fullScreen
        // test@mail.ru
        view?.present(confirmVC)
    }
}
