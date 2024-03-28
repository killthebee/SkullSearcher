protocol LikedViewModelProtocol: AnyObject {
    var vacancies: [VacancyPreviewData]? { get set }
    func setVacancies()
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())? { get set }
    var refreshCollectionView: (() async -> ())? { get set }
    func dismiss()
    func presentDetail(_ index: Int)
    var setFavorites: ((_ favorites: Set<String>) -> ())? { get set }
    var updateTulBar: (() -> ())? { get set }
}

class LikedViewModel: MoreViewModelProtocol, LikedViewModelProtocol {
    
    var vacancies: [VacancyPreviewData]?
    
    var coordinator: LikedCoordinatorProtocol?
    var storageService: FavoriteStorageProtocol?
    
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())?
    var refreshCollectionView: (() async -> ())?
    var setFavorites: ((_ favorites: Set<String>) -> ())?
    var updateTulBar: (() -> ())?
    
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
    
    func addFavorite(_ id: String) {
        storageService?.addToFavorite(id)
    }
    
    func removeFromFavorite(_ id: String) {
        storageService?.removeFromFavorite(id)
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }
    
    func presentDetail(_ index: Int) {
        coordinator?.presentDetail(index)
    }
}
