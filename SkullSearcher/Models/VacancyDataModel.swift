struct VacancyPreviewData {
    let id: String
    let lookingText: String?
    let title: String
    let adress: String?
    let company: String
    let salary: String?
    let experience: String
    let publishedDate: String
    let isFavorite: Bool
}

struct VacancyFullData {
    let id: String
    let title: String
    let adress: String?
    let company: String
    let salary: String?
    let experience: String
    let schedules: String
    let appliedText: String
    let lookingText: String?
    let isFavorite: Bool
    let aboutText: String
    let resonsobilityText: String
    let questions: [String]
}
