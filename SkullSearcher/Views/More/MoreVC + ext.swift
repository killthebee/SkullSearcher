import UIKit

extension MoreViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return vacanciesPreviews.count
        }
    }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int { 2 }
        
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
            cell.configure(viewModel)
            
            return cell
        } else {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: VacancyCell.cellIdentifier,
                    for: indexPath
                ) as? VacancyCell
            else {
                fatalError("Unable deque cell...")
            }
            if vacanciesPreviews.count > 0 {
                cell.configure(
                    previewData: vacanciesPreviews[indexPath.row]
                )
                cell.bsDelegate = self
                cell.tabBarUpdater = self
            }
            
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: MoreSupCell.cellIdentifier,
            for: indexPath) as? MoreSupCell
        else {
            fatalError("Cannot create header view")
        }
        supplementaryView.configure(vacanciesPreviews.count)
        
        return supplementaryView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            viewModel?.presentDetail(indexPath.row)
        }
    }
}
