import UIKit

//TODO: i need protocol!

class MockApiService {
    
    static let shared = MockApiService()
    
    private func makeURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.host = Urls.mockHost.rawValue
        urlComponents.path = Urls.mockPath.rawValue
        urlComponents.scheme = HTTPScheme.secure.rawValue
        print(urlComponents)
        
        return urlComponents.url
    }
    
    private func setupRequest(_ url: URL) -> URLRequest {
        print(url.absoluteString)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
    
    func getNewImagesData() async -> MockData? {
        var mockData: MockData? = nil
        guard let url = makeURL() else { return mockData }
        let request = setupRequest(url)
        await Networking.shared.performRequest(
            request
        ) { (result: Result<MockData, Error>) async in
            switch result {
            case let .success(downloadedMockData):
                mockData = downloadedMockData
            case let .failure(error):
//                self.handleError(
//                    error,
//                    source: .newImages
//                )
                print("puk srenk: \(error)")
            }
        }
        
        return mockData
    }
}
