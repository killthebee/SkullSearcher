protocol ConfirmViewModelProtocol: AnyObject {
    var email: String? { get set }
    var setSentHeaderText: ((_ header: String) -> ())? { get set }
    func setSentHeader()
    func savePinInput(_ tag: Int, num: String?, add: Bool)
    var switchCodeField: ((_ tag: Int) async -> ())? { get set }
    var activateButton: (() -> ())? { get set }
    var deactivateButton: (() -> ())? { get set }
    func performCodeFieldSwitch()
    func presentMainScreen()
}

extension ConfirmViewModelProtocol {
    func savePinInput(_ tag: Int, num: String?) {
        return savePinInput(tag, num: num, add: true)
    }
}

class ConfirmViewModel: ConfirmViewModelProtocol {
    
    var coordinator: ConfirmCoordinatorProtocol?
    
    var email: String?
    var currentTag = 0
    var pin = Array<String?>(repeating: nil, count: 4)
    var buttonActivated = false
    
    var setSentHeaderText: ((_ header: String) -> ())?
    var switchCodeField: ((_ tag: Int) async -> ())?
    var activateButton: (() -> ())?
    var deactivateButton: (() -> ())?
    
    func setSentHeader() {
        let header = sentHeaderString + " " + (email ?? "")
        setSentHeaderText?(header)
    }
    
    func savePinInput(_ tag: Int, num: String?, add: Bool = true) {
        if !add {
            currentTag = tag
            pin[tag] = nil
            assestCurrentPin()
            
            return
        }
        pin[tag] = num
        assestCurrentPin()
        if tag < 3 {
            currentTag = tag + 1
            performCodeFieldSwitch()
            
            return
        }
        if tag == 3 { currentTag = tag }
    }
    
    func performCodeFieldSwitch() {
        Task {
            await switchCodeField?(currentTag)
        }
    }
    
    func assestCurrentPin() {
        for pinNum in pin {
            if pinNum == nil {
                if buttonActivated { deactivateButton?() }
                return
            }
        }
        buttonActivated = true
        activateButton?()
    }
    
    func presentMainScreen() {
        coordinator?.presentMainScreen()
    }
}
