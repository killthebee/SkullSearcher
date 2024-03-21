import UIKit

class CodeField: UITextField {
    
    convenience init(_ fieldTag: Int) {
        self.init()
        configure(fieldTag)
        
    }
    
    func configure(_ fieldTag: Int) {
        layer.cornerRadius = 8
        backgroundColor = grey2
        self.tag = fieldTag
        contentVerticalAlignment = .center
        attributedPlaceholder = NSAttributedString(
            string: "*",
            attributes: [
                NSAttributedString.Key.foregroundColor: grey3!,
                NSAttributedString.Key.font: starsFont!
            ]
        )
        textAlignment = .center
        keyboardType = UIKeyboardType.numberPad
        tintColor = .white
        textColor = .white
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect =  CGRect(
            x: bounds.minX,
            y: CGFloat(7),
            width: bounds.width,
            height: bounds.height - 3
        )
        
        return rect
    }
}
