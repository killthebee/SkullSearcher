import UIKit

class CompanyAndAddressCell: UICollectionViewCell {
    
    static let cellIdentifier = "CompanyAndAddressCelldentifier"
    
    func configure(_ vacancy: VacancyFullData?) {
        guard let vacancy = vacancy else { return }
        companyLable.text = vacancy.company
        addressLable.text = vacancy.adress
    }
    
    private let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = grey1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let companyLable: UILabel = {
        let lable = UILabel()
        lable.text = "Мобиус"
        lable.font = title3Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let mapImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "map")
        
        return view
    }()
    
    private let checkIcon = UIImageView(
        image: UIImage(named: "checkIcon2")
    )
    
    private let addressLable: UILabel = {
        let lable = UILabel()
        lable.text = "Минск, улица Бирюзова, 4/5"
        lable.font = text1Font
        lable.textColor = .white
        
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
        [coverView, companyLable, mapImageView, addressLable, checkIcon
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        contentView.addSubview(coverView)
        [companyLable, mapImageView, addressLable, checkIcon].forEach{
            coverView.addSubview($0)
        }
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
            
            companyLable.topAnchor.constraint(
                equalTo: coverView.topAnchor,
                constant: 2 * spacing
            ),
            companyLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: 2 * spacing
            ),
            companyLable.heightAnchor.constraint(
                equalToConstant: 19
            ),
            
            checkIcon.topAnchor.constraint(
                equalTo: coverView.topAnchor,
                constant: 2 * spacing + 2
            ),
            checkIcon.leadingAnchor.constraint(
                equalTo: companyLable.trailingAnchor,
                constant: spacing
            ),
            checkIcon.heightAnchor.constraint(
                equalToConstant: 16
            ),
            checkIcon.widthAnchor.constraint(
                equalToConstant: 16
            ),
            
            addressLable.bottomAnchor.constraint(
                equalTo: coverView.bottomAnchor,
                constant: -2 * spacing
            ),
            addressLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: 2 * spacing
            ),
            addressLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            mapImageView.topAnchor.constraint(
                equalTo: companyLable.bottomAnchor,
                constant: spacing
            ),
            mapImageView.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: 2 * spacing
            ),
            mapImageView.bottomAnchor.constraint(
                equalTo: addressLable.topAnchor,
                constant: -1 * spacing
            ),
            mapImageView.heightAnchor.constraint(
                equalToConstant: 58
            ),
            mapImageView.widthAnchor.constraint(
                equalToConstant: 296
            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

