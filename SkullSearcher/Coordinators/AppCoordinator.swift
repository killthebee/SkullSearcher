import UIKit

final class AppCoordinator: Coordinator {
    
    private var window: UIWindow?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    var loginCoordinator : LoginCoordinator?
    
    @discardableResult
    func start() -> Presentable? {
        loginCoordinator = LoginCoordinator()
        let loginVC = loginCoordinator?.start()
        self.window?.rootViewController = loginVC as? LoginViewController
        self.window?.makeKeyAndVisible()
        
        return loginVC
    }
}
