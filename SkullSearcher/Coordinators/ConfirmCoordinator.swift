class ConfirmCoordinator: Coordinator {
    
    func start() -> Presentable? {
        let confirmVC = ConfirmViewController()
        
        return confirmVC
    }
}
