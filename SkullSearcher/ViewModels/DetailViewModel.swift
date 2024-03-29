protocol detailViewModelProtocol: AnyObject {
    func makeVacancyData()
    var setVacancyFullData: ((_ vacancyFullData: VacancyFullData) -> ())? { get set }
    func dismiss()
}

class detailViewModel: detailViewModelProtocol {
    
    var apiService: ApiServiceProtocol?
    var storageService: FavoriteStorageProtocol?
    
    var coordinator: DetailCoordinatorProtocol?
    
    var vacancy: Vacancy?
    var vacancyIndex: Int?
    
    var setVacancyFullData: ((_ vacancyFullData: VacancyFullData) -> ())?
    
    func makeVacancyData() {
        guard
            let vacancyIndex = vacancyIndex,
            let vacancyData = apiService?.vananciesData[vacancyIndex],
            let favorites = storageService?.retriveFavorite()
        else {
            return 
        }
        let vacancyFullData = VacancyFullData(
            title: vacancyData.title,
            adress: makeFullAddress(vacancyData.address),
            company: vacancyData.company,
            salary: vacancyData.salary.full,
            experience: makeExpText(vacancyData.experience),
            schedules: makeSchedules(vacancyData.schedules),
            appliedText: makeAppliedText(vacancyData.appliedNumber),
            lookingText: makeLookingNumberTextDetail(
                vacancyData.lookingNumber
            ),
            isFavorite: favorites.contains(vacancyData.id),
            aboutText: vacancyData.description ?? "Нет описания компании",
            resonsobilityText: vacancyData.responsibilities,
            questions: vacancyData.questions
        )
        
        setVacancyFullData?(vacancyFullData)
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }
}
