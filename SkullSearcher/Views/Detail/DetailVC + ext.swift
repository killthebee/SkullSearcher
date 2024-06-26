import UIKit

extension DetailViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch section {
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { 6 }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TopHeaderCell.cellIdentifier,
                    for: indexPath
                ) as? TopHeaderCell
            else {
                fatalError("Unable deque cell...")
            }
            cell.viewModel = viewModel
            cell.tabBarUpdater = self
            cell.configure(vacancyFullData)
            
            return cell
        } else if indexPath.section == 1 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainInfoCell.cellIdentifier,
                    for: indexPath
                ) as? MainInfoCell
            else {
                fatalError("Unable deque cell...")
            }
            cell.configure(vacancyFullData)
        
            return cell
        } else if indexPath.section == 2 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: StatisticsCell.cellIdentifier,
                    for: indexPath
                ) as? StatisticsCell
            else {
                fatalError("Unable deque cell...")
            }
            if indexPath.row == 0 {
                cell.configure(vacancyFullData?.appliedText, statisticsIcons[0])
            } else {
                cell.configure(vacancyFullData?.lookingText, statisticsIcons[1])
            }
            
            
            return cell
        } else if indexPath.section == 3 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CompanyAndAddressCell.cellIdentifier,
                    for: indexPath
                ) as? CompanyAndAddressCell
            else {
                fatalError("Unable deque cell...")
            }
            cell.configure(vacancyFullData)
            
            return cell
        } else if indexPath.section == 4 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AboutCell.cellIdentifier,
                    for: indexPath
                ) as? AboutCell
            else {
                fatalError("Unable deque cell...")
            }
            let cellWidth = view.frame.width - 2 * 16
            cell.configure(vacancyFullData, cellWidth)
            
            return cell
        } else if indexPath.section == 5 {
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: questionsCell.cellIdentifier,
                    for: indexPath
                ) as? questionsCell
            else {
                fatalError("Unable deque cell...")
            }
            cell.configure(vacancyFullData)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}
