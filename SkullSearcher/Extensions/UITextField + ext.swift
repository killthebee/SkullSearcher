import UIKit

extension UITextField {
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = shadow?.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 2
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath

        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
    func setLeftIcon(_ icon: UIImage?) {

        let padding = 10
        let size = 24

        let outerView = UIView(
            frame: CGRect(x: 0, y: 0, width: size + (2 * padding), height: size)
        )
        let iconView = UIImageView(
            frame: CGRect(x: padding, y: 0, width: size, height: size)
        )
        iconView.image = icon
        outerView.addSubview(iconView)

        leftView = outerView
        leftViewMode = .always
      }
    
    func applyCustomClearButton() {
        clearButtonMode = .never

        let clearButton = UIButton(
            frame: CGRect(x: 0, y: 0, width: 24, height: 24)
        )
        clearButton.setImage(
            UIImage(named: "clearIcon"),
            for: .normal
        )
        clearButton.addTarget(
            self,
            action: #selector(clearClicked),
            for: .touchUpInside
        )
        let padding: CGFloat = 8
        let rightView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: clearButton.frame.width + padding,
                height: clearButton.frame.height
            )
        )
        rightView.addSubview(clearButton)
        self.rightView = rightView
    }
    
    @objc
    func clearClicked(sender:UIButton) {
        text = ""
        rightViewMode = .never
    }
}
