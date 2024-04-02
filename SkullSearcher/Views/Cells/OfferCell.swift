import UIKit

class OfferCell: UICollectionViewCell {
    
    static let cellIdentifier = "OfferCellIdentifier"
    
    func configure(image: UIImage?, text: String = "decoy \ntext goes wrum") {
        if image == UIImage(named: "locationIcon2") {
            iconCoverView.backgroundColor = darkBlue
        } else {
            iconCoverView.backgroundColor = darkGreen
        }
        icon.image = image
        offerLableHeight.constant = 34
        offerLable.text = text
    }
    
    func addOffer() {
        offerLableHeight.constant = 54
        let offerAttriString = NSMutableAttributedString(string: offerString)
        let offerRange = (offerString as NSString).range(of: offerStringRagne)
        
        offerAttriString.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: green!,
            range: offerRange
        )
        offerLable.attributedText = offerAttriString
        offerLable.isUserInteractionEnabled = true
        offerLable.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(bumpCV))
        )
    }
    
    func addLoop() { // figma is kinda messed up so
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "loopIcon")
        attachment.bounds = CGRect(
            x: 0, y: -2,
            width: 14,
            height: 14
        )

        let attachmentString = NSAttributedString(attachment: attachment)
        let completeText = NSMutableAttributedString(string: "")
        let string = NSMutableAttributedString(
            string: offerLable.text ?? "Вакансии рядом с вами"
        )
        completeText.append(attachmentString)
        completeText.append(string)
        offerLable.attributedText = completeText
    }
    
    @objc
    private func bumpCV() {
        print("bump cv")
    }
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = grey1
        view.layer.cornerRadius = 8

        return view
    }()
    
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
    
    private lazy var offerLableHeight = offerLable.heightAnchor.constraint(
        equalToConstant: 34
    )
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellBackgroundView.leadingAnchor.constraint(
                equalTo: leadingAnchor
            ),
            cellBackgroundView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            
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
            offerLableHeight,
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
