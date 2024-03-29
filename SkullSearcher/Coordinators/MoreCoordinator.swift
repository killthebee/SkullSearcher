protocol MoreCoordinatorProtocol: AnyObject {
    func dismiss()
    func presentDetail(_ index: Int)
    func presentLikes()
}

class MoreCoordinator: Coordinator, MoreCoordinatorProtocol {
    
    weak var view: MoreViewController?
    
    var vacancies: [VacancyPreviewData]?
    
    func start() -> Presentable? {
        let moreVC = MoreViewController()
        let viewModel = MoreViewModel()
        viewModel.vacancies = vacancies
        viewModel.storageService = FavoriteStorage.shared
        moreVC.viewModel = viewModel
        viewModel.coordinator = self
        view = moreVC
        
        return moreVC
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
