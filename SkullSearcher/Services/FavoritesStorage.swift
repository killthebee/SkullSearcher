import Foundation

protocol FavoriteStorageProtocol: AnyObject {
    func setFavorite(_ favorites: Set<String>)
    func retriveFavorite() -> Set<String>?
    func removeFavorites()
    func addToFavorite(_ id: String)
    func removeFromFavorite(_ id: String)
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
    
    func removeFavorites() {
        UserDefaults.standard.removeObject(forKey: "favorites")
    }
    
    func addToFavorite(_ id: String) {
        guard var favorites = retriveFavorite() else { return }
        favorites.insert(id)
        setFavorite(favorites)
    }
    
    func removeFromFavorite(_ id: String) {
        guard var favorites = retriveFavorite() else { return }
        favorites.remove(id)
        setFavorite(favorites)
    }
}
