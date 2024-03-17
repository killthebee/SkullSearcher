protocol ConfirmCoordinatorProtocol: AnyObject {
    func presentMainScreen()
}

class ConfirmCoordinator: Coordinator, ConfirmCoordinatorProtocol {
    
    weak var view: Presentable?
    
    var email: String?
    
    func start() -> Presentable? {
        let confirmVC = ConfirmViewController()
        let viewModel = ConfirmViewModel()
        viewModel.email = email
        confirmVC.viewModel = viewModel
        viewModel.coordinator = self
        view = confirmVC
        
        return confirmVC
    }
    
    func presentMainScreen() {
        let mainScreenCoordinator = MainScreenCoordinator()
        guard
            let mainVC = mainScreenCoordinator.start() as? MainViewController
        else
            { return }
        mainVC.modalPresentationStyle = .fullScreen
        view?.present(mainVC)
    }
}
