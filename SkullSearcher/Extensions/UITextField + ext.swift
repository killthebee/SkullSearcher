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
}
