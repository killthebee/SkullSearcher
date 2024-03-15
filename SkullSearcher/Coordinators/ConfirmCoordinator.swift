class ConfirmCoordinator: Coordinator {
    
    var email: String?
    
    func start() -> Presentable? {
        let confirmVC = ConfirmViewController()
        let viewModel = ConfirmViewModel()
        viewModel.email = email
        confirmVC.viewModel = viewModel
        
        return confirmVC
    }
}
