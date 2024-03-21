import UIKit

class MoreSupCell: UICollectionReusableView {
    
    static let cellIdentifier = "MoreSupCellIdentifier"
    
    func configure(_ vacanciesNum: Int) {
        if vacanciesNum <= 1 {
            vacanciesNumLable.text = "1 вакансия"
        } else {
            vacanciesNumLable.text = "\(vacanciesNum) вакансий"
        }
        
    }
    
    let vacanciesNumLable: UILabel = {
        let lable = UILabel()
        lable.font = text1Font
        lable.textColor = .white
        
        return lable
    }()
    
    let filterLable: UILabel = {
        let lable = UILabel()
        lable.text = moreFilterString
        lable.font = text1Font
        lable.textColor = .systemBlue
        
        return lable
    }()
    
    let upDownImageView = UIImageView(image: UIImage(named: "upDownIcon"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [vacanciesNumLable, filterLable, upDownImageView
        ].forEach { addSubview($0) }
        [vacanciesNumLable, filterLable, upDownImageView
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        let constraints: [NSLayoutConstraint] = [
            vacanciesNumLable.topAnchor.constraint(equalTo: topAnchor),
            vacanciesNumLable.leadingAnchor.constraint(equalTo: leadingAnchor),
            vacanciesNumLable.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            upDownImageView.centerYAnchor.constraint(
                equalTo: centerYAnchor,
                constant: 1
            ),
            upDownImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            upDownImageView.widthAnchor.constraint(equalToConstant: 16),
            upDownImageView.heightAnchor.constraint(equalToConstant: 16),
            
            filterLable.topAnchor.constraint(equalTo: topAnchor),
            filterLable.trailingAnchor.constraint(
                equalTo: upDownImageView.leadingAnchor,
                constant: -4
            ),
            filterLable.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
