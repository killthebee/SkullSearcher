protocol DetailCoordinatorProtocol: AnyObject {
    func dismiss()
}

class DetailCoordinator: Coordinator, DetailCoordinatorProtocol {
    
    weak var view: Presentable?
    
    var apiService: ApiServiceProtocol?
    
    var vacancyIndex: Int?
    
    func start() -> Presentable? {
        let detailVC = detailViewController()
//        let viewModel = MoreViewModel()
//        viewModel.vacancies = vacancies
//        moreVC.viewModel = viewModel
//        viewModel.coordinator = self
        view = detailVC

        return detailVC
    }

    func dismiss() {
        view?.dismiss()
    }
}
