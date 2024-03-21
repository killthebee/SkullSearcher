import UIKit

class VacancyCell: UICollectionViewCell {
    
    static let cellIdentifier = "VacancyCellIdentifier"
    
    private let vacancyContainerView = UIView()
    
    weak var bsDelegate: BSPresenterDelegate?
    
    @objc
    private func applyToVacancy() {
        bsDelegate?.presentBS()
    }
    
    func configure(previewData: VacancyPreviewData) {
        if let lookingText = previewData.lookingText {
            lookingLable.text = lookingText
            infoStack.addArrangedSubview(lookingLable)
        }
        
        titleLable.text = previewData.title
        infoStack.addArrangedSubview(titleLable)
        
        if let salaryText = previewData.salary {
            salaryLable.text = salaryText
            infoStack.addArrangedSubview(salaryLable)
        }
        
        cityLable.text = previewData.adress
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "checkIcon")
        attachment.bounds = CGRect(
            x: 0, y: -2,
            width: 10,
            height: 10
        )

        let attachmentString = NSAttributedString(attachment: attachment)
        let string = NSMutableAttributedString(string: previewData.company, attributes: [:])
        
        string.append(attachmentString)
        companyNameLable.attributedText = string
        infoStack.addArrangedSubview(cityCompanyStack)
        
        expLable.text = previewData.experience
        infoStack.addArrangedSubview(expLable)
        
        publishDateLable.text = previewData.publishedDate
        infoStack.addArrangedSubview(publishDateLable)
        
        if previewData.isFavorite {
            likeIconView.image = UIImage(named: "heartIcon3")
        }
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
//        lable.text = "Опубликовано 20 февраля"
        
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
    
    private let likeIconView = UIImageView(
        image: UIImage(named: "heartIcon2")
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
         applyButton, likeIconView, cityCompanyStack, infoStack, expContainer
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
//        checkImageView, likeIconView, infoStack
//        contentView.addSubview(hm)
        [applyButton, infoStack, likeIconView
        ].forEach{ contentView.addSubview($0) }
        [expIconView, expLable].forEach{ expContainer.addSubview($0) }
    }
    
    private lazy var cityCompanyStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [cityLable, companyNameLable]
        )
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    private let expContainer = UIView()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(
//            arrangedSubviews: [
//                lookingLable, titleLable, salaryLable, cityCompanyStack,
//                expContainer, publishDateLable
//            ]
//            arrangedSubviews: [
//                lookingLable, titleLable, cityCompanyStack,
//                expContainer, publishDateLable
//            ]
        )
        stack.axis = .vertical
        stack.distribution = .fillEqually
        
        return stack
    }()
    
    private let hm = UIView()
    
    private func setUpConstrains() {
        let spacing: CGFloat = 16
        
        
        let constraints: [NSLayoutConstraint] = [
            
            applyButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -1 * spacing
            ),
            applyButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: spacing
            ),
            
            applyButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -1 * spacing
            ),
            applyButton.heightAnchor.constraint(equalToConstant: 32),
            
            expIconView.widthAnchor.constraint(equalToConstant: 16),
            expIconView.heightAnchor.constraint(equalToConstant: 16),
            expIconView.leadingAnchor.constraint(
                equalTo: expContainer.leadingAnchor
            ),
            expIconView.centerYAnchor.constraint(
                equalTo: expContainer.centerYAnchor
            ),
            
            expLable.heightAnchor.constraint(equalToConstant: 16),
            expLable.leadingAnchor.constraint(
                equalTo: expIconView.trailingAnchor,
                constant: 8
            ),
            expLable.trailingAnchor.constraint(
                equalTo: expContainer.trailingAnchor
            ),
            expLable.centerYAnchor.constraint(
                equalTo: expContainer.centerYAnchor
            ),
            
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
            
            infoStack.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            infoStack.leadingAnchor.constraint(
                equalTo: applyButton.leadingAnchor
            ),
            infoStack.bottomAnchor.constraint(
                equalTo: applyButton.topAnchor,
                constant: -5
            ),
            infoStack.trailingAnchor.constraint(equalTo: applyButton.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
