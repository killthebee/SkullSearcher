import UIKit

class StatisticsCell: UICollectionViewCell {
    
    static let cellIdentifier = "StatisticsCellIdentifier"
    
    private let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = darkGreen
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let appliedLable: UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.textColor = .white
        lable.font = text1Font
        lable.text = "147 человек уже \nоткликнулись"
        
        return lable
    }()
    
    private let iconCoverView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = green
        
        return view
    }()
    
    private let personIconView = UIImageView(
        image: UIImage(named: "profileIcon2")
    )
    
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
        [coverView, appliedLable, iconCoverView, personIconView
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        contentView.addSubview(coverView)
        [appliedLable, iconCoverView].forEach{
            coverView.addSubview($0)
        }
        iconCoverView.addSubview(personIconView)
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            coverView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            coverView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            coverView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            appliedLable.centerYAnchor.constraint(
                equalTo: coverView.centerYAnchor
            ),
            appliedLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            appliedLable.widthAnchor.constraint(
                equalTo: coverView.widthAnchor,
                multiplier: 0.8
            ),
            
            iconCoverView.trailingAnchor.constraint(
                equalTo: coverView.trailingAnchor,
                constant: -1 * spacing
            ),
            iconCoverView.topAnchor.constraint(
                equalTo: coverView.topAnchor,
                constant: spacing
            ),
            iconCoverView.widthAnchor.constraint(
                equalToConstant: 16
            ),
            iconCoverView.heightAnchor.constraint(
                equalToConstant: 16
            ),
            
            personIconView.centerYAnchor.constraint(
                equalTo: iconCoverView.centerYAnchor
            ),
            personIconView.centerXAnchor.constraint(
                equalTo: iconCoverView.centerXAnchor
            ),
            personIconView.widthAnchor.constraint(
                equalToConstant: 8
            ),
            personIconView.heightAnchor.constraint(
                equalToConstant: 8
            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

