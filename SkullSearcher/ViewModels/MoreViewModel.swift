protocol MoreViewModelProtocol: AnyObject {
    var vacancies: [VacancyPreviewData]? { get set }
    func setVacancies()
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())? { get set }
    var refreshCollectionView: (() async -> ())? { get set }
    func dismiss()
    func presentDetail(_ index: Int)
}

class MoreViewModel: MoreViewModelProtocol {
    
    var vacancies: [VacancyPreviewData]?
    
    var coordinator: MoreCoordinatorProtocol?
    
    var setVacanciesPreviews: ((_ previews: [VacancyPreviewData]) -> ())?
    var refreshCollectionView: (() async -> ())?
    
    func setVacancies() {
        Task {
            guard let vacancies = vacancies else { return }
            setVacanciesPreviews?(vacancies)
            await refreshCollectionView?()
        }
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }
    
    func presentDetail(_ index: Int) {
        coordinator?.presentDetail(index)
    }
}
