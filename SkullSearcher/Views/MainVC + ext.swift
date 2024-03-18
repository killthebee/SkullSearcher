import UIKit

extension MainViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
        
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        case 2:
            return 3
        default:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 3 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TopSearchCell.cellIdentifier,
                    for: indexPath
                ) as? TopSearchCell
            else {
                fatalError("Unable deque cell...")
            }
            
            return cell
        } else if indexPath.section == 1 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: OfferCell.cellIdentifier,
                    for: indexPath
                ) as? OfferCell
            else {
                fatalError("Unable deque cell...")
            }
            
            return cell
        } else if indexPath.section == 2 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: VacancyCell.cellIdentifier,
                    for: indexPath
                ) as? VacancyCell
            else {
                fatalError("Unable deque cell...")
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: VacanciesSupCell.cellIdentifier,
            for: indexPath) as? VacanciesSupCell
        else {
            fatalError("Cannot create header view")
        }
        
        return supplementaryView
    }
}
