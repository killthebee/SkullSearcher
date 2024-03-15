import UIKit

class CodeField: UITextField {
    
    let fieldTag = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        layer.cornerRadius = 8
        backgroundColor = grey2
        tag = fieldTag
    }
}
