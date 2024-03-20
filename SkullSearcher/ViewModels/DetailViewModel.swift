protocol detailViewModelProtocol: AnyObject {
    func makeVacancyData()
}

class detailViewModel: detailViewModelProtocol {
    
    var apiService: ApiServiceProtocol?
    
    var vacancy: Vacancy?
    var vacancyIndex: Int?
    
    func makeVacancyData() {
        guard
            let vacancyIndex = vacancyIndex,
            let vacancyData = apiService?.vananciesData[vacancyIndex]
        else
            { return }
//        print(vacancyData)
    }
}
