import UIKit

class AboutCell: UICollectionViewCell {
    
    static let cellIdentifier = "AboutCellIdentifier"
    
    func configure(_ vacancy: VacancyFullData?, _ cellWidth: CGFloat) {
        guard let vacancy = vacancy else { return }
        aboutCompanyLable.text = vacancy.aboutText
        responsobilityLable.text = vacancy.resonsobilityText
        let aboutLableHeight = heightForView(
            text: vacancy.aboutText,
            font: text1Font!,
            width: cellWidth
        )
        let resposobilityLableHight = heightForView(
            text: vacancy.resonsobilityText,
            font: text1Font!,
            width: cellWidth
        )
        let cellHeight: CGFloat = (
            aboutLableHeight + 8 + 24 + 8 + resposobilityLableHight
        )
        
        cellHeightAnchor.constant = cellHeight < 290 ? cellHeight : cellHeight - 50
    }
    
    private func heightForView(
        text: String,
        font: UIFont,
        width: CGFloat
    ) -> CGFloat {
        let label: UILabel = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: width,
                height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        
        return label.frame.height
    }
    
    let aboutCompanyLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = text1Font
        lable.numberOfLines = 0
        lable.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
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
        lable.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
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
        [aboutCompanyLable, titleLable, responsobilityLable, coverView
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        contentView.addSubview(coverView)
        [aboutCompanyLable, titleLable, responsobilityLable
        ].forEach{coverView.addSubview($0)}
    }
    
    private let coverView = UIView()
    
    lazy var cellHeightAnchor = coverView.heightAnchor.constraint(equalToConstant: 200)
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        let constraints: [NSLayoutConstraint] = [
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            coverView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            coverView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            cellHeightAnchor,
            
            aboutCompanyLable.topAnchor.constraint(
                equalTo: coverView.topAnchor
            ),
            aboutCompanyLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor
            ),
            aboutCompanyLable.trailingAnchor.constraint(
                equalTo: coverView.trailingAnchor
            ),

            titleLable.topAnchor.constraint(
                equalTo: aboutCompanyLable.bottomAnchor,
                constant: spacing
            ),
            titleLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor
            ),
            titleLable.heightAnchor.constraint(
                equalToConstant: 24
            ),
            titleLable.trailingAnchor.constraint(
                equalTo: coverView.trailingAnchor
            ),

            responsobilityLable.topAnchor.constraint(
                equalTo: titleLable.bottomAnchor,
                constant: spacing
            ),
            responsobilityLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor
            ),
            responsobilityLable.trailingAnchor.constraint(
                equalTo: coverView.trailingAnchor
            ),
//            aboutCompanyLable.topAnchor.constraint(
//                equalTo: contentView.topAnchor
//            ),
//            aboutCompanyLable.leadingAnchor.constraint(
//                equalTo: contentView.leadingAnchor
//            ),
//            aboutCompanyLable.trailingAnchor.constraint(
//                equalTo: contentView.trailingAnchor
//            ),
//
//            titleLable.topAnchor.constraint(
//                equalTo: aboutCompanyLable.bottomAnchor,
//                constant: spacing
//            ),
//            titleLable.leadingAnchor.constraint(
//                equalTo: contentView.leadingAnchor
//            ),
//            titleLable.heightAnchor.constraint(
//                equalToConstant: 24
//            ),
//            titleLable.trailingAnchor.constraint(
//                equalTo: contentView.trailingAnchor
//            ),
//
//            responsobilityLable.topAnchor.constraint(
//                equalTo: titleLable.bottomAnchor,
//                constant: spacing
//            ),
//            responsobilityLable.leadingAnchor.constraint(
//                equalTo: contentView.leadingAnchor
//            ),
//            responsobilityLable.trailingAnchor.constraint(
//                equalTo: contentView.trailingAnchor
//            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
        cellHeightAnchor.priority = UILayoutPriority(999)
    }
}

