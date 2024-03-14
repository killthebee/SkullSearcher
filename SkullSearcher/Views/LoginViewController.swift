import UIKit

class LoginViewController: UIViewController {
    
    private let textLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont(name: "SFProDisplay-Semibold", size: 40)
        lable.text = " test "
        
        return lable
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(textLable)
        textLable.frame = view.bounds
    }
}
