protocol MoreViewModelProtocol: AnyObject {
    var vacancies: [VacancyPreviewData]? { get set }
    func setVacancies()
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())? { get set }
    var refreshCollectionView: (() async -> ())? { get set }
    func dismiss()
    func presentDetail(_ index: Int)
    var setFavorites: ((_ favorites: Set<String>) -> ())? { get set }
}

class MoreViewModel: MoreViewModelProtocol {
    
    var vacancies: [VacancyPreviewData]?
    
    var coordinator: MoreCoordinatorProtocol?
    var storageService: FavoriteStorageProtocol?
    
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())?
    var refreshCollectionView: (() async -> ())?
    var setFavorites: ((_ favorites: Set<String>) -> ())?
    
    func setVacancies() {
        Task {
            guard let vacancies = vacancies else { return }
            setVacanciesPreviews?(vacancies)
            getFavorites()
            await refreshCollectionView?()
        }
    }
    
    func getFavorites() {
        guard let favorites = storageService?.retriveFavorite() else { return }
        setFavorites?(favorites)
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }
    
    func presentDetail(_ index: Int) {
        coordinator?.presentDetail(index)
    }
}
