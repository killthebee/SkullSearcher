protocol ConfirmViewModelProtocol: AnyObject {
    var email: String? { get set }
    var setSentHeaderText: ((_ header: String) -> ())? { get set }
    func setSentHeader()
}

class ConfirmViewModel: ConfirmViewModelProtocol {
    
    var email: String?
    
    var setSentHeaderText: ((_ header: String) -> ())?
    
    func setSentHeader() {
        let header = sentHeaderString + " " + (email ?? "")
        setSentHeaderText?(header)
    }
}
