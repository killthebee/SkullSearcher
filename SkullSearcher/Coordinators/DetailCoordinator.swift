protocol DetailCoordinatorProtocol: AnyObject {
    func dismiss()
    func presentLikes()
}

class DetailCoordinator: Coordinator, DetailCoordinatorProtocol {
    
    weak var view: DetailViewController?
    
    var apiService: ApiServiceProtocol?
    
    var vacancyIndex: Int?
    
    func start() -> Presentable? {
        let detailVC = DetailViewController()
        let viewModel = detailViewModel()
        apiService = FakeMockApiService.shared
        viewModel.vacancyIndex = vacancyIndex
        viewModel.apiService = apiService
        viewModel.storageService = FavoriteStorage.shared
        detailVC.viewModel = viewModel
        viewModel.coordinator = self
        view = detailVC

        return detailVC
    }

    func dismiss() {
        view?.dismiss()
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
