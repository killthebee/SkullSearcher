class LoginCoordinator: Coordinator {
    
    func start() -> Presentable? {
        let logincVC = LoginViewController()
        
        return logincVC
    }
}
