//import UIKit
//import Foundation
//
//fileprivate let tabBarItemTag: Int = 10090
//extension UITabBar {
//    public func addItemBadge(atIndex index: Int) {
//        guard let itemCount = self.items?.count, itemCount > 0 else {
//            return
//        }
//        guard index < itemCount else {
//            return
//        }
//        removeItemBadge(atIndex: index)
//        
//        let badgeView = UIView()
//        badgeView.tag = tabBarItemTag + Int(index)
//        badgeView.layer.cornerRadius = 8
//        badgeView.backgroundColor = UIColor.red
//        
//        let FavoriteVacanciesCount = UILabel()
//        FavoriteVacanciesCount.text = "1"
//        FavoriteVacanciesCount.textColor = .white
//        FavoriteVacanciesCount.textAlignment = .center
//        FavoriteVacanciesCount.font = numberFont
//        
//        let tabFrame = self.frame
//        let percentX = (CGFloat(index) + 0.56) / CGFloat(itemCount)
//        let x = (percentX * tabFrame.size.width).rounded(.up) - 1
//        let y = (CGFloat(0.1) * tabFrame.size.height).rounded(.up) + 5
//        badgeView.frame = CGRect(x: x, y: y, width: 16, height: 16)
//        addSubview(badgeView)
//        badgeView.addSubview(FavoriteVacanciesCount)
//        FavoriteVacanciesCount.frame = badgeView.bounds
//    }
//    
//    //return true if removed success.
//    @discardableResult
//    public func removeItemBadge(atIndex index: Int) -> Bool {
//        for subView in self.subviews {
//            if subView.tag == (tabBarItemTag + index) {
//                subView.removeFromSuperview()
//                return true
//            }
//        }
//        return false
//    }
//}
