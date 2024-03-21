import Foundation

protocol FavoriteStorageProtocol: AnyObject {
    func setFavorite(_ favorites: Set<String>)
    func retriveFavorite() -> Set<String>?
}

class FavoriteStorage: FavoriteStorageProtocol {
    
    static let shared = FavoriteStorage()
    
    func setFavorite(_ favorites: Set<String>) {
        let favoritesArray = Array(favorites)
        UserDefaults.standard.set(favoritesArray, forKey: "favorites")
    }
    
    func retriveFavorite() -> Set<String>? {
        guard
            let favoritesArray = UserDefaults.standard.array(
            forKey: "favorites"
        ) as? [String]
        else {
            return nil
        }
        
        return Set(favoritesArray)
    }
}
