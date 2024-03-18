import UIKit

class OfferCell: UICollectionViewCell {
    
    static let cellIdentifier = "OfferCellIdentifier"
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = grey1
        view.layer.cornerRadius = 8

        return view
    }()
    
    // TODO: get data from above
    private let icon = UIImageView(image: UIImage(named: "locationIcon"))
    
    private let offerLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = title4Font
        lable.numberOfLines = 0
        lable.text = "decoy \ntext goes wrum"
        
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        disableAutoresizing()
        addSubviews()
        setUpConstrains()
    }
    
    private func disableAutoresizing() {
        [icon, offerLable, cellBackgroundView].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(cellBackgroundView)
        [icon, offerLable].forEach{ cellBackgroundView.addSubview($0) }
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            icon.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            icon.leadingAnchor.constraint(
                equalTo: cellBackgroundView.leadingAnchor,
                constant: spacing
            ),
            icon.widthAnchor.constraint(equalToConstant: 32),
            icon.heightAnchor.constraint(equalToConstant: 32),
            
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
