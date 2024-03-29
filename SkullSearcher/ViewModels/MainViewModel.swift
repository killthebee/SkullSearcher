protocol MainViewModelProtocol: AnyObject {
    func setData()
    var refreshCollectionView: (() async -> ())? { get set }
    var setOffersTexts: ((_ texts: [String]) -> ())? { get set }
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())? { get set }
    func presentMoreScreen()
    func presentDetail(_ index: Int)
    var updateTabBar: (() -> ())? { get set }
    var storageService: FavoriteStorageProtocol? { get set }
}

protocol LikesPresenterProtocol: AnyObject {
    func presentLikes()
}

class MainViewModel: MainViewModelProtocol, LikesPresenterProtocol {
    
    var apiService: ApiServiceProtocol?
    var storageService: FavoriteStorageProtocol?
    
    var vacanciesPreviews: [VacancyPreviewData]?
    
    var coordinator: MainScreenCoordinatorProtocol?
    
    var refreshCollectionView: (() async -> ())?
    var setOffersTexts: ((_ texts: [String]) -> ())?
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())?
    var setFavorites: ((_ favorites: Set<String>) -> ())?
    var updateTabBar: (() -> ())?
    
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
    
    func setupVacancyCellPreview(
        _ vacanciesData: [Vacancy]
    ) -> [VacancyPreviewData] {
        let favorites = storageService?.retriveFavorite()
        let needToPopulateStorage = favorites == nil
        var ids = Set<String>()
        
        let previewData = vacanciesData.enumerated().reduce(
            into: [VacancyPreviewData]())
        {
            if needToPopulateStorage && $1.element.isFavorite {
                ids.insert($1.element.id)
            }
            
            $0.append(VacancyPreviewData(
                id: $1.element.id,
                lookingText: makeLookingNumberText($1.element.lookingNumber),
                title: $1.element.title,
                adress: $1.element.address.town,
                company: $1.element.company,
                salary: $1.element.salary.short == nil ? nil : $1.element.salary.short,
                experience: $1.element.experience.previewText,
                publishedDate: makePublishedData($1.element.publishedDate),
                isFavorite: false
            ))
        }
        
        vacanciesPreviews = previewData
        if needToPopulateStorage {
            storageService?.setFavorite(ids)
        }
        
        return previewData
    }
    
    func presentMoreScreen() {
        coordinator?.presentMoreScreen(vacanciesPreviews)
    }
    
    func presentDetail(_ index: Int) {
        coordinator?.presentDetail(index)
    }
    
    func presentLikes() {
        coordinator?.presentLikes()
    }
}
