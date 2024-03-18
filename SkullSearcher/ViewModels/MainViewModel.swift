protocol MainViewModelProtocol: AnyObject {
    
}

class MainViewModel: MainViewModelProtocol {
    
    var apiService: ApiServiceProtocol?
}
