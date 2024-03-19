import UIKit

class OfferCell: UICollectionViewCell {
    
    static let cellIdentifier = "OfferCellIdentifier"
    
    func configure(image: UIImage?, text: String = "decoy \ntext goes wrum") {
        if image == UIImage(named: "locationIcon2") {
            iconCoverView.backgroundColor = darkBlue
        }
        icon.image = image
        offerLable.text = text
    }
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = grey1
        view.layer.cornerRadius = 8

        return view
    }()
    
    // TODO: get data from above
    private let icon = UIImageView(image: UIImage(named: "locationIcon"))
    
    private let iconCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = darkGreen
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    private let offerLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = title4Font
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
        [icon, offerLable, cellBackgroundView, iconCoverView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(cellBackgroundView)
        [iconCoverView, offerLable].forEach{ cellBackgroundView.addSubview($0) }
        iconCoverView.addSubview(icon)
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            iconCoverView.topAnchor.constraint(
                equalTo: cellBackgroundView.topAnchor,
                constant: 10
            ),
            iconCoverView.leadingAnchor.constraint(
                equalTo: cellBackgroundView.leadingAnchor,
                constant: spacing
            ),
            iconCoverView.widthAnchor.constraint(equalToConstant: 32),
            iconCoverView.heightAnchor.constraint(equalToConstant: 32),
            
            icon.centerXAnchor.constraint(
                equalTo: iconCoverView.centerXAnchor
            ),
            icon.centerYAnchor.constraint(
                equalTo: iconCoverView.centerYAnchor
            ),
//            icon.centerYAnchor.constraint(
//                equalTo: iconCoverView.centerYAnchor,
//                constant: 3
//            ),
            icon.widthAnchor.constraint(equalToConstant: 24),
            icon.heightAnchor.constraint(equalToConstant: 24),
            
            offerLable.topAnchor.constraint(
                equalTo: icon.bottomAnchor,
                constant: 16
            ),
            offerLable.leadingAnchor.constraint(
                equalTo: cellBackgroundView.leadingAnchor,
                constant: spacing
            ),
            offerLable.trailingAnchor.constraint(
                equalTo: cellBackgroundView.trailingAnchor,
                constant: -1 * spacing
            ),
            offerLable.heightAnchor.constraint(equalToConstant: 34),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
