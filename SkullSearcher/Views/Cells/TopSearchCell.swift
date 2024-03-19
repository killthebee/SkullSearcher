import UIKit

class TopSearchCell: UICollectionViewCell {
    
    static let cellIdentifier = "TopSearchCellIdentifier"
    
    private let searchView: UIView = {
        let view = UIView()
        view.backgroundColor = grey1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let searchIconImageView = UIImageView(
        image: UIImage(named: "loopIcon2")
    )
    
    private let searchLable: UILabel = {
        let lable = UILabel()
        lable.font = text1Font
        lable.text = searchString
        lable.textColor = grey4
//        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
//            .strokeColor : UIColor.black,
//            .foregroundColor : grey4!,
//            .strokeWidth : -2.0,
//        ]
//        lable.attributedText = NSAttributedString(
//            string: searchString,
//            attributes: strokeTextAttributes
//        )
        // outline is in figma, but not in description i dunno
        
        return lable
    }()
    
    private let filterView: UIView = {
        let view = UIView()
        view.backgroundColor = grey1
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private let filterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "fitlerIcon2")
        
        return view
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
        [searchView, searchIconImageView, searchLable, filterImageView,
         filterView
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [searchView, filterView].forEach{ contentView.addSubview($0) }
        [searchIconImageView, searchLable].forEach{
            searchView.addSubview($0)
        }
        filterView.addSubview(filterImageView)
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            filterView.bottomAnchor.constraint(equalTo: bottomAnchor),
            filterView.trailingAnchor.constraint(
                equalTo: trailingAnchor
            ),
            filterView.heightAnchor.constraint(equalToConstant: 40),
            filterView.widthAnchor.constraint(equalToConstant: 40),
            
            filterImageView.centerYAnchor.constraint(
                equalTo: filterView.centerYAnchor
            ),
            filterImageView.centerXAnchor.constraint(
                equalTo: filterView.centerXAnchor
            ),
            filterImageView.heightAnchor.constraint(equalToConstant: 24),
            filterImageView.widthAnchor.constraint(equalToConstant: 24),
            
            searchView.topAnchor.constraint(equalTo: topAnchor),
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchView.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchView.trailingAnchor.constraint(
                equalTo: filterView.leadingAnchor,
                constant: -7
            ),
            
            searchIconImageView.centerYAnchor.constraint(
                equalTo: searchView.centerYAnchor
            ),
            searchIconImageView.leadingAnchor.constraint(
                equalTo: searchView.leadingAnchor,
                constant: spacing
            ),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 24),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            searchLable.centerYAnchor.constraint(
                equalTo: searchView.centerYAnchor
            ),
            searchLable.leadingAnchor.constraint(
                equalTo: searchIconImageView.trailingAnchor,
                constant: spacing
            ),
            searchLable.trailingAnchor.constraint(
                equalTo: searchLable.trailingAnchor
            ),
            searchLable.heightAnchor.constraint(equalToConstant: 24),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
