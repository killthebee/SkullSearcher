struct MockData: Decodable {
//    let offers: [Offers]
    let vacancies: [Vacancies]
}

struct Offers: Decodable {
    let id: String?
    let title: String
    let link: String
    let button: offerButton?
}

struct offerButton: Decodable {
    let text: String
}

struct Vacancies: Decodable {
    let id: String
    let lookingNumber: Int?
    let title: String
    let adress: Adress?
    let company: String
    let experience: Experience
    let publishedDate: String
    let isFavorite: Bool
    let salary: Salary
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]
}

struct Adress: Decodable {
    let town: String
    let street: String
    let house: String
}

struct Experience: Decodable {
    let previewText: String
    let text: String
}

struct Salary: Decodable {
    let full: String
}
