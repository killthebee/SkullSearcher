protocol MoreCoordinatorProtocol: AnyObject {
    func dismiss()
}

class MoreCoordinator: Coordinator, MoreCoordinatorProtocol {
    
    weak var view: Presentable?
    
    var vacancies: [VacancyPreviewData]?
    
    func start() -> Presentable? {
        let moreVC = moreViewController()
        let viewModel = MoreViewModel()
        viewModel.vacancies = vacancies
        moreVC.viewModel = viewModel
        viewModel.coordinator = self
        view = moreVC
        
        return moreVC
    }
    
    func dismiss() {
        view?.dismiss()
    }
}
