import UIKit

protocol ApiServiceProtocol: AnyObject {
    func getMockData() async -> MockData?
}

class MockApiService: ApiServiceProtocol {
    
    static let shared = MockApiService()
    
    var vananciesData: [Vacancy] = []
    
    private func makeURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.host = Urls.mockHost.rawValue
        urlComponents.path = Urls.mockPath.rawValue
        urlComponents.scheme = HTTPScheme.secure.rawValue
        
        return urlComponents.url
    }
    
    private func setupRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
    
    func getMockData() async -> MockData? {
        var mockData: MockData? = nil
        guard let url = makeURL() else { return mockData }
        let request = setupRequest(url)
        await Networking.shared.performRequest(
            request
        ) { (result: Result<MockData, Error>) async in
            switch result {
            case let .success(downloadedMockData):
                self.vananciesData = downloadedMockData.vacancies
                mockData = downloadedMockData
            case let .failure(error):
//                self.handleError(
//                    error,
//                    source: .mockData
//                )
                print("puk srenk: \(error)")
            }
        }
        
        return mockData
    }
}
