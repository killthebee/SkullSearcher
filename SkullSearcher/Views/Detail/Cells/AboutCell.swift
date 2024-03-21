import UIKit

class AboutCell: UICollectionViewCell {
    
    static let cellIdentifier = "AboutCellIdentifier"
    
    func configure(_ vacancy: VacancyFullData?) {
        guard let vacancy = vacancy else { return }
        aboutCompanyLable.text = vacancy.aboutText
        responsobilityLable.text = vacancy.resonsobilityText
    }
    
    let aboutCompanyLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = text1Font
        lable.numberOfLines = 0
        
        return lable
    }()
    
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = title3Font
        lable.text = responsobilityHeader
        
        return lable
    }()
    
    let responsobilityLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = text1Font
        lable.numberOfLines = 0
        
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        disableAutoresizing()
        addSubviews()
        setUpConstrains()
    }
    
    private func disableAutoresizing() {
        [aboutCompanyLable, titleLable, responsobilityLable
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [aboutCompanyLable, titleLable, responsobilityLable
        ].forEach{contentView.addSubview($0)}
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            aboutCompanyLable.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            aboutCompanyLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            aboutCompanyLable.heightAnchor.constraint(
                equalToConstant: 187
            ),
            aboutCompanyLable.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            titleLable.topAnchor.constraint(
                equalTo: aboutCompanyLable.bottomAnchor,
                constant: spacing
            ),
            titleLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            titleLable.heightAnchor.constraint(
                equalToConstant: 24
            ),
            titleLable.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            responsobilityLable.topAnchor.constraint(
                equalTo: titleLable.bottomAnchor,
                constant: spacing
            ),
            responsobilityLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            responsobilityLable.heightAnchor.constraint(
                equalToConstant: 204
            ),
            responsobilityLable.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

