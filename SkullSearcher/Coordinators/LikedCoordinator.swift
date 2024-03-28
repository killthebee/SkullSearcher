protocol LikedCoordinatorProtocol: AnyObject {
    func dismiss()
    func presentDetail(_ index: Int)
}

class LikedCoordinator: Coordinator, LikedCoordinatorProtocol {
    
    weak var view: Presentable?
    
    var vacancies: [VacancyPreviewData]?
    
    func start() -> Presentable? {
        let likedVC = LikedViewController()
        let viewModel = LikedViewModel()
        viewModel.vacancies = vacancies
        viewModel.storageService = FavoriteStorage.shared
        likedVC.viewModel = viewModel
        viewModel.coordinator = self
        view = likedVC

        return likedVC
    }
    
    func dismiss() {
        view?.dismiss()
    }
    
    func presentDetail(_ index: Int) {
        let detailCoordinator = DetailCoordinator()
        detailCoordinator.vacancyIndex = index
        guard
            let detailVC = detailCoordinator.start() as? DetailViewController
        else
            { return }
        detailVC.modalPresentationStyle = .fullScreen
        view?.present(detailVC)
    }
}
