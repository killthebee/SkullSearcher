class LoginCoordinator: Coordinator {
    
    func start() -> Presentable? {
        let logincVC = LoginViewController()
        let viewModel = LoginViewModel()
        logincVC.viewModel = viewModel
        
        return logincVC
    }
}
