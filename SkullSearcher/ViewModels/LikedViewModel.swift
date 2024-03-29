protocol LikedViewModelProtocol: AnyObject {
    var vacancies: [VacancyPreviewData] { get set }
    func setVacancies()
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())? { get set }
    var refreshCollectionView: (() async -> ())? { get set }
    var updateLable: (() async -> ())? { get set }
    func dismiss()
    func presentDetail(_ index: Int)
    var updateTabBar: (() -> ())? { get set }
    var updateParent: (() -> ())? { get set }
}

class LikedViewModel: LikedViewModelProtocol {
    var vacancies: [VacancyPreviewData] = []
    var relativeIds: [Int: Int] = [:]
    
    var coordinator: LikedCoordinatorProtocol?
    var storageService: FavoriteStorageProtocol?
    var apiService: ApiServiceProtocol?
    
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())?
    var refreshCollectionView: (() async -> ())?
    var updateTabBar: (() -> ())?
    var updateLable: (() async -> ())?
    var updateParent: (() -> ())?
    
    func setVacancies() {
        Task {
            setupVacancyCellPreview()
            setVacanciesPreviews?(vacancies)
            await refreshCollectionView?()
            await updateLable?()
        }
    }
    
    func setupVacancyCellPreview(){
        guard
            let vacanciesData = apiService?.vananciesData,
            let favorites = storageService?.retriveFavorite()
        else {
            return
        }
        
        var relativeId = 0
        let previewData = vacanciesData.enumerated().reduce(
            into: [VacancyPreviewData]())
        {
            if favorites.contains($1.element.id) {
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
                relativeIds[relativeId] = $1.offset
                relativeId += 1
            }
        }
        
        vacancies = previewData
    }
    
    func dismiss() {
        updateParent?()
        coordinator?.dismiss()
    }
    
    func presentDetail(_ index: Int) {
        let id = relativeIds[index] ?? 0
        coordinator?.presentDetail(id)
    }
}
