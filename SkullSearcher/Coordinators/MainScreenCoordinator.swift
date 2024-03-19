protocol MainScreenCoordinatorProtocol: AnyObject {
    func presentMoreScreen(_ vacancies: [VacancyPreviewData]?)
}

class MainScreenCoordinator: Coordinator, MainScreenCoordinatorProtocol {
    
    weak var view: Presentable?
    
    var apiService: ApiServiceProtocol?
    
    func start() -> Presentable? {
        let mainVC = MainViewController()
        let viewModel = MainViewModel()
        apiService = MockApiService.shared
        viewModel.apiService = apiService
        mainVC.viewModel = viewModel
        view = mainVC
        
        return mainVC
    }
    
    func presentMoreScreen(_ vacancies: [VacancyPreviewData]?) {
        let moreCoordinator = MoreCoordinator()
        moreCoordinator.vacancies = vacancies
        guard
            let moreVC = moreCoordinator.start() as? moreViewController
        else
            { return }
        moreVC.modalPresentationStyle = .fullScreen
        view?.present(moreVC)
    }
}
