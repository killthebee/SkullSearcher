class MoreCoordinator: Coordinator {
    
    weak var view: Presentable?
    
    func start() -> Presentable? {
        let moreVC = moreViewController()
//        let viewModel = ConfirmViewModel()
//        viewModel.email = email
//        confirmVC.viewModel = viewModel
//        viewModel.coordinator = self
        view = moreVC
        
        return moreVC
    }
}
