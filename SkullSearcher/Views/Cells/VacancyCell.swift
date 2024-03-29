import UIKit

class VacancyCell: UICollectionViewCell {
    
    static let cellIdentifier = "VacancyCellIdentifier"
    
    weak var bsDelegate: BSPresenterDelegate?
    weak var tabBarUpdater: CanUpdateLikesProtocol?
    weak var storageService: FavoriteStorageProtocol?
    
    private var vacId = ""
    
    @objc
    private func applyToVacancy() {
        bsDelegate?.presentBS()
    }
    
    @objc
    private func handleLikeTap() {
        guard
            let storageService = storageService,
            let favorites = storageService.retriveFavorite()
        else {
            likeIconView.image = UIImage(named: "heartIcon2")
            return
        }
        self.storageService = storageService
        if favorites.contains(vacId) {
            likeIconView.image = UIImage(named: "heartIcon2")
            storageService.removeFromFavorite(vacId)
        } else {
            likeIconView.image = UIImage(named: "heartIcon3")
            storageService.addToFavorite(vacId)
        }
        tabBarUpdater?.updateTabBar()
    }
    
    private let vacancyContainerView = UIView()
    
    func configure(
        previewData: VacancyPreviewData
    ) {
        self.storageService = FavoriteStorage.shared
        if let lookingText = previewData.lookingText {
            lookingHeightAnchor.constant = 24
            lookingPositionAnchor.constant = -16
            lookingLable.text = lookingText
        } else {
            lookingHeightAnchor.constant = 0
            lookingPositionAnchor.constant = 0
        }
        
        titleLable.text = previewData.title
        var titleLableHeight = heightForView(
            text: previewData.title,
            font: title3Font!,
            width: 220
        )
        titleLableHeight = titleLableHeight > 19 ? titleLableHeight : 19
        titleHeightAnchor.constant = titleLableHeight
        
        if let salaryText = previewData.salary {
            salaryLable.text = salaryText
            salaryHeightAnchor.constant = 24
            salaryPositionAnchor.constant = -16
        } else {
            salaryHeightAnchor.constant = 0
            salaryPositionAnchor.constant = 0
        }
        
        cityLable.text = previewData.adress
        
        companyNameLable.text = previewData.company
        
        expLable.text = previewData.experience
        
        publishDateLable.text = previewData.publishedDate
        
        if let storageService = storageService {
            self.storageService = storageService
        }
        guard
            let favorites = storageService?.retriveFavorite()
        else {
            likeIconView.image = UIImage(named: "heartIcon2")
            return
        }
        vacId = previewData.id
        if favorites.contains(vacId) {
            likeIconView.image = UIImage(named: "heartIcon3")
        } else {
            likeIconView.image = UIImage(named: "heartIcon2")
        }
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
    
    private let lookingLable: UILabel = {
        let lable = UILabel()
        lable.font = text1Font
        lable.textColor = green
        
        return lable
    }()
    
    private let titleLable: UILabel = {
        let lable = UILabel()
        lable.font = title3Font
        lable.textColor = .white
        lable.numberOfLines = 0
        
        return lable
    }()
    
    private let cityLable: UILabel = {
        let lable = UILabel()
        lable.font = text1Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let companyNameLable: UILabel = {
        let lable = UILabel()
        lable.font = text1Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let salaryLable: UILabel = {
        let lable = UILabel()
        lable.font = title2Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let expIconView = UIImageView(
        image: UIImage(named: "baggageIcon2")
    )
    
    private let expLable: UILabel = {
        let lable = UILabel()
        lable.font = text1Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let publishDateLable: UILabel = {
        let lable = UILabel()
        lable.font = text1Font
        lable.textColor = grey3
        
        return lable
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = green
        button.layer.cornerRadius = 16
        button.setTitle(applyString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = buttonText2Font
        button.addTarget(
            self, action: #selector(applyToVacancy),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private lazy var likeIconView: UIImageView = {
        let view = UIImageView(
            image: UIImage(named: "heartIcon2")
        )
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleLikeTap)
            )
        )
        
        return view
    }()
    
    private let checkIconView = UIImageView(
        image: UIImage(named: "checkIcon2")
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = grey1
        layer.cornerRadius = 8
        disableAutoresizing()
        addSubviews()
        setUpConstrains()
    }
    
    private func disableAutoresizing() {
        [lookingLable, titleLable, cityLable, companyNameLable,
         salaryLable, expIconView, expLable, publishDateLable,
         applyButton, likeIconView, coverView, checkIconView
         ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        contentView.addSubview(coverView)
        [applyButton, likeIconView, publishDateLable, expIconView,
         expLable, companyNameLable, checkIconView, cityLable, salaryLable,
         titleLable, lookingLable
        ].forEach{ coverView.addSubview($0) }
    }
    
    private let coverView = UIView()
    private lazy var salaryHeightAnchor = salaryLable.heightAnchor.constraint(
        equalToConstant: 24
    )
    private lazy var titleHeightAnchor = titleLable.heightAnchor.constraint(
        equalToConstant: 19
    )
    private lazy var lookingHeightAnchor = lookingLable.heightAnchor.constraint(
        equalToConstant: 24
    )
    
    private lazy var salaryPositionAnchor = salaryLable.bottomAnchor.constraint(
        equalTo: cityLable.topAnchor,
        constant: -16
    )
    private lazy var lookingPositionAnchor = lookingLable.bottomAnchor.constraint(
        equalTo: titleLable.topAnchor,
        constant: -16
    )

    
    private func setUpConstrains() {
        let spacing: CGFloat = 16
        
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
            
            applyButton.bottomAnchor.constraint(
                equalTo: coverView.bottomAnchor,
                constant: -1 * spacing
            ),
            applyButton.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            
            applyButton.trailingAnchor.constraint(
                equalTo: coverView.trailingAnchor,
                constant: -1 * spacing
            ),
            applyButton.heightAnchor.constraint(equalToConstant: 32),
            
            likeIconView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: spacing
            ),
            likeIconView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -1 * spacing
            ),
            likeIconView.heightAnchor.constraint(equalToConstant: 24),
            likeIconView.widthAnchor.constraint(equalToConstant: 24),
            
            publishDateLable.bottomAnchor.constraint(
                equalTo: applyButton.topAnchor,
                constant: -1 * spacing
            ),
            publishDateLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            publishDateLable.trailingAnchor.constraint(
                equalTo: coverView.trailingAnchor
            ),
            publishDateLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            expIconView.bottomAnchor.constraint(
                equalTo: publishDateLable.topAnchor,
                constant: -1 * spacing
            ),
            expIconView.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            expIconView.widthAnchor.constraint(equalToConstant: 16),
            expIconView.heightAnchor.constraint(
                equalToConstant: 16
            ),
            
            expLable.bottomAnchor.constraint(
                equalTo: publishDateLable.topAnchor,
                constant: -1 * spacing
            ),
            expLable.leadingAnchor.constraint(
                equalTo: expIconView.trailingAnchor,
                constant: 8
            ),
            expLable.trailingAnchor.constraint(
                equalTo: coverView.trailingAnchor
            ),
            expLable.heightAnchor.constraint(
                equalToConstant: 16
            ),
            
            companyNameLable.bottomAnchor.constraint(
                equalTo: expIconView.topAnchor,
                constant: -1 * spacing
            ),
            companyNameLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            companyNameLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            checkIconView.bottomAnchor.constraint(
                equalTo: expIconView.topAnchor,
                constant: -1 * spacing
            ),
            checkIconView.leadingAnchor.constraint(
                equalTo: companyNameLable.trailingAnchor,
                constant: 8
            ),
            checkIconView.heightAnchor.constraint(
                equalToConstant: 16
            ),
            checkIconView.widthAnchor.constraint(
                equalToConstant: 16
            ),
            
            cityLable.bottomAnchor.constraint(
                equalTo: companyNameLable.topAnchor,
                constant: -8
            ),
            cityLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            cityLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            salaryPositionAnchor,
            salaryLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            salaryHeightAnchor,
            
            titleLable.bottomAnchor.constraint(
                equalTo: salaryLable.topAnchor,
                constant: -1 * spacing
            ),
            titleLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor,
                constant: spacing
            ),
            titleLable.widthAnchor.constraint(
                equalToConstant: 220
            ),
            titleHeightAnchor,
            
            
            lookingHeightAnchor,
            lookingLable.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: spacing
            ),
            lookingPositionAnchor,
            lookingLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: spacing
            ),
            lookingLable.widthAnchor.constraint(equalToConstant: 220),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
