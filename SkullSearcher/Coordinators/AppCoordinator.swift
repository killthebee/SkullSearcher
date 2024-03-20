import UIKit

final class AppCoordinator: Coordinator {
    
    private var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
//    var loginCoordinator : MainScreenCoordinator?
    var loginCoordinator : LoginCoordinator?
    
    @discardableResult
    func start() -> Presentable? {
        loginCoordinator = LoginCoordinator()
        let loginVC = loginCoordinator?.start()
        self.window?.rootViewController = loginVC as? LoginViewController
        self.window?.makeKeyAndVisible()

        return loginVC
//        loginCoordinator = MainScreenCoordinator()
//        loginCoordinator?.apiService = MockApiService.shared
//        let loginVC = loginCoordinator?.start() as? MainViewController
//        let viewModel = MainViewModel()
//        viewModel.apiService = loginCoordinator?.apiService
//        viewModel.coordinator = loginCoordinator
//        loginVC?.viewModel = viewModel
//        self.window?.rootViewController = loginVC
//        self.window?.makeKeyAndVisible()
//
//        return loginVC
    }
}
