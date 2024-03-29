protocol MoreViewModelProtocol: AnyObject {
    var vacancies: [VacancyPreviewData]? { get set }
    func setVacancies()
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())? { get set }
    var refreshCollectionView: (() async -> ())? { get set }
    func dismiss()
    func presentDetail(_ index: Int)
    var updateTabBar: (() -> ())? { get set }
    var updateParent: (() -> ())? { get set }
}

class MoreViewModel: MoreViewModelProtocol, LikesPresenterProtocol {
    
    var vacancies: [VacancyPreviewData]?
    
    var coordinator: MoreCoordinatorProtocol?
    var storageService: FavoriteStorageProtocol?
    
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())?
    var refreshCollectionView: (() async -> ())?
    var setFavorites: ((_ favorites: Set<String>) -> ())?
    var updateTabBar: (() -> ())?
    var updateParent: (() -> ())?
    
    func setVacancies() {
        Task {
            guard let vacancies = vacancies else { return }
            setVacanciesPreviews?(vacancies)
            await refreshCollectionView?()
        }
    }
        
    func dismiss() {
        updateParent?()
        coordinator?.dismiss()
    }
    
    func presentDetail(_ index: Int) {
        coordinator?.presentDetail(index)
    }
    
    func presentLikes() {
        coordinator?.presentLikes()
    }
}
