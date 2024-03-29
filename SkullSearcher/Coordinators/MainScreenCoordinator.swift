protocol MainScreenCoordinatorProtocol: AnyObject {
    func presentMoreScreen(_ vacancies: [VacancyPreviewData]?)
    func presentDetail(_ index: Int)
    func presentLikes()
}

class MainScreenCoordinator: Coordinator, MainScreenCoordinatorProtocol {
    
    weak var view: MainViewController?
    
    var apiService: ApiServiceProtocol?
    
    func start() -> Presentable? {
        let mainVC = MainViewController()
        let viewModel = MainViewModel()
        apiService = FakeMockApiService.shared
        viewModel.apiService = apiService
        viewModel.storageService = FavoriteStorage.shared
        viewModel.coordinator = self
        mainVC.viewModel = viewModel
        view = mainVC
        
        return mainVC
    }
    
    func presentMoreScreen(_ vacancies: [VacancyPreviewData]?) {
        let moreCoordinator = MoreCoordinator()
        moreCoordinator.vacancies = vacancies
        guard
            let moreVC = moreCoordinator.start() as? MoreViewController
        else
            { return }
        moreVC.mainVCDelegate = view
        moreVC.modalPresentationStyle = .fullScreen
        view?.present(moreVC)
    }
    
    func presentDetail(_ index: Int) {
        let detailCoordinator = DetailCoordinator()
        detailCoordinator.vacancyIndex = index
        guard
            let detailVC = detailCoordinator.start() as? DetailViewController
        else
            { return }
        detailVC.parentVCDelegate = view
        detailVC.modalPresentationStyle = .fullScreen
        view?.present(detailVC)
    }
    
    func presentLikes() {
        let likesCoordinator = LikedCoordinator()
        guard
            let likesVC = likesCoordinator.start() as? LikedViewController
        else
            { return }
        likesVC.parentVCDelegate = view
        likesVC.modalPresentationStyle = .fullScreen
        view?.present(likesVC)
    }
}
