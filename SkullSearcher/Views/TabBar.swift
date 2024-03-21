import UIKit

class DasboardTabBar: UITabBar {
    
    static let shared = DasboardTabBar()
    private let customDelegate = DashboardTabBarDelegate()
    private let storageService = FavoriteStorage.shared
    
    private let tabBarItemTag: Int = 10090
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = customDelegate
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        isTranslucent = false
        barTintColor = .black
        layer.borderColor = grey1?.cgColor
        layer.borderWidth = 2
        items = makeBarItems()
    }
    
    private func makeItem(_ title: String, _ image: UIImage?, _ tag: Int) -> UITabBarItem {
        let item = UITabBarItem(
            title: title,
            image: image,
            tag: tag
        )
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: -10)
        item.setTitleTextAttributes(
            [NSAttributedString.Key.font: tabTextFont!],
            for: .normal
        )
        
        return item
    }
    
    private func makeBarItems() -> [UITabBarItem] {
        let items = [
            makeItem("Поиск", UIImage(named: "loopIcon"), 1),
            makeItem("Избранное", UIImage(named: "heartIcon"), 2),
            makeItem("Отклики", UIImage(named: "emailIcon"), 3),
            makeItem("Сообщения", UIImage(named: "messageIcon"), 4),
            makeItem("Профиль", UIImage(named: "profileIcon"), 5),
        ]
        
        return items
    }
    
    public func addItemBadge(atIndex index: Int) {
        guard
            let favoritesCount = storageService.retriveFavorite()?.count
        else {
            return
        }
        guard let itemCount = self.items?.count, itemCount > 0 else {
            return
        }
        guard index < itemCount else {
            return
        }
        removeItemBadge(atIndex: index)
        
        let badgeView = UIView()
        badgeView.tag = tabBarItemTag + Int(index)
        badgeView.layer.cornerRadius = 8
        badgeView.backgroundColor = UIColor.red
        
        let FavoriteVacanciesCount = UILabel()
        
        FavoriteVacanciesCount.text = String(favoritesCount)
        FavoriteVacanciesCount.textColor = .white
        FavoriteVacanciesCount.textAlignment = .center
        FavoriteVacanciesCount.font = numberFont
        
        let tabFrame = self.frame
        let percentX = (CGFloat(index) + 0.56) / CGFloat(itemCount)
        let x = (percentX * tabFrame.size.width).rounded(.up) - 1
        let y = (CGFloat(0.1) * tabFrame.size.height).rounded(.up) + 5
        badgeView.frame = CGRect(x: x, y: y, width: 16, height: 16)
        addSubview(badgeView)
        badgeView.addSubview(FavoriteVacanciesCount)
        FavoriteVacanciesCount.frame = badgeView.bounds
    }
    
    @discardableResult
    public func removeItemBadge(atIndex index: Int) -> Bool {
        for subView in self.subviews {
            if subView.tag == (tabBarItemTag + index) {
                subView.removeFromSuperview()
                return true
            }
        }
        return false
    }
}

class DashboardTabBarDelegate: NSObject {}

extension DashboardTabBarDelegate : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.tag)
    }
}
