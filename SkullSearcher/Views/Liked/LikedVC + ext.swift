import UIKit

extension LikedViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int { vacanciesPreviews.count }
        
    func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
        
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
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
            cell.tabBarUpdater = self
            cell.bsDelegate = self
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.presentDetail(indexPath.row)
    }
}
