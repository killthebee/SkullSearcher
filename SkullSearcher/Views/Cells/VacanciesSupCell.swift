import UIKit

class VacanciesSupCell: UICollectionReusableView {
    
    static let cellIdentifier = "VacanciesSupCellIdentifier"
    
    let vacanciesLable: UILabel = {
        let lable = UILabel()
        lable.text = vacanciesHeaderString
        lable.font = title2Font
        lable.textColor = .white
        
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubview(vacanciesLable)
        vacanciesLable.frame = bounds
    }
}
