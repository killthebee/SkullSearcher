class MainScreenCoordinator: Coordinator {
    
    var email: String?
    
    func start() -> Presentable? {
        let mainVC = MainViewController()
        let viewModel = MainViewModel()
        mainVC.viewModel = viewModel
        
        return mainVC
    }
}
