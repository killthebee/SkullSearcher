class MainScreenCoordinator: Coordinator {
    
    var apiService: ApiServiceProtocol?
    
    func start() -> Presentable? {
        let mainVC = MainViewController()
        let viewModel = MainViewModel()
        apiService = MockApiService.shared
        viewModel.apiService = apiService
        mainVC.viewModel = viewModel
        
        return mainVC
    }
}
