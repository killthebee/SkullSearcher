protocol MainScreenCoordinatorProtocol: AnyObject {
    func presentMoreScreen(_ vacancies: [VacancyPreviewData]?)
    func presentDetail(_ index: Int)
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
    
    func presentDetail(_ index: Int) {
        let detailCoordinator = DetailCoordinator()
        detailCoordinator.vacancyIndex = index
        guard
            let detailVC = detailCoordinator.start() as? detailViewController
        else
            { return }
        detailVC.modalPresentationStyle = .fullScreen
        view?.present(detailVC)
    }
}
