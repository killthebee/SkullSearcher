import Foundation

class FakeMockApiService: ApiServiceProtocol {
    
    static let shared = FakeMockApiService()
    
    var vananciesData: [Vacancy] = []
    
    private func loadJson(filename fileName: String) -> MockData? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MockData.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    func getMockData() async -> MockData? {
        guard let mockData = loadJson(filename: "MockData") else { return nil }
        vananciesData = mockData.vacancies
        
        return mockData
    }
}
