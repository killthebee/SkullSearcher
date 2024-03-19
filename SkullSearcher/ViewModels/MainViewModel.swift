protocol MainViewModelProtocol: AnyObject {
    func setData()
    var refreshCollectionView: (() async -> ())? { get set }
    var setOffersTexts: ((_ texts: [String]) -> ())? { get set }
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())? { get set }
    func presentMoreScreen()
}

class MainViewModel: MainViewModelProtocol {
    
    var apiService: ApiServiceProtocol?
    
//    var mockData: MockData?
    
    var coordinator: MainScreenCoordinatorProtocol?
    
    var refreshCollectionView: (() async -> ())?
    var setOffersTexts: ((_ texts: [String]) -> ())?
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())?
    
    func setData() {
        Task {
            guard let mockData = await apiService?.getMockData() else { return }
            let offersTexts = makeOfferTexts(mockData.offers)
            setOffersTexts?(offersTexts)
            let vanaciesPreview = setupVacancyCellPreview(mockData.vacancies)
            setVacanciesPreviews?(vanaciesPreview)
            await refreshCollectionView?()
        }
    }
    
    func makeOfferTexts(_ offersData: [Offer]) -> [String] {
        return offersData.reduce(into: [String]()) {
            $0.append($1.title)
        }
        
    }
    func setupVacancyCellPreview(_ vacanciesData: [Vacancy]) -> [VacancyPreviewData] {
        
        let previewData = vacanciesData.enumerated().reduce(into: [VacancyPreviewData]()) {
            $0.append(VacancyPreviewData(
                lookingText: makeLookingNumberText($1.element.lookingNumber),
                title: $1.element.title,
                adress: $1.element.address.town,
                company: $1.element.company,
                salary: $1.element.salary.short == nil ? nil : $1.element.salary.short,
                experience: $1.element.experience.previewText,
                publishedDate: makePublishedData($1.element.publishedDate),
                isFavorite: $1.element.isFavorite
            ))
        }
        
        return previewData
    }
    
    func presentMoreScreen() {
        coordinator?.presentMoreScreen()
    }
}
