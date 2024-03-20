protocol DetailCoordinatorProtocol: AnyObject {
    func dismiss()
}

class DetailCoordinator: Coordinator, DetailCoordinatorProtocol {
    
    weak var view: Presentable?
    
    var apiService: ApiServiceProtocol?
    
    var vacancyIndex: Int?
    
    func start() -> Presentable? {
        let detailVC = detailViewController()
        let viewModel = detailViewModel()
        apiService = MockApiService.shared
        viewModel.vacancyIndex = vacancyIndex
        viewModel.apiService = apiService
        detailVC.viewModel = viewModel
//        viewModel.coordinator = self
        view = detailVC

        return detailVC
    }

    func dismiss() {
        view?.dismiss()
    }
}
