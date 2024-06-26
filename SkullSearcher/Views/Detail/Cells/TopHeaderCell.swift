import UIKit

class TopHeaderCell: UICollectionViewCell {
    
    static let cellIdentifier = "TopHeaderCellIdentifier"
    
    weak var viewModel: detailViewModelProtocol?
    weak var storageService: FavoriteStorageProtocol?
    weak var tabBarUpdater: CanUpdateLikesProtocol?
    
    private var vacId = ""
    
    func configure(_ vacancy: VacancyFullData?) {
        guard let vacancy = vacancy else { return }
        self.storageService = FavoriteStorage.shared
        guard
            let favorites = storageService?.retriveFavorite()
        else {
            heartIconView.image = UIImage(named: "heartIcon4")
            return
        }
        vacId = vacancy.id
        if favorites.contains(vacId) {
            heartIconView.image = UIImage(named: "heartIcon3")
        } else {
            heartIconView.image = UIImage(named: "heartIcon4")
        }
    }
    
    @objc
    private func handleLikeTap() {
        guard
            let storageService = storageService,
            let favorites = storageService.retriveFavorite()
        else {
            heartIconView.image = UIImage(named: "heartIcon4")
            return
        }
        self.storageService = storageService
        if favorites.contains(vacId) {
            heartIconView.image = UIImage(named: "heartIcon4")
            storageService.removeFromFavorite(vacId)
        } else {
            heartIconView.image = UIImage(named: "heartIcon3")
            storageService.addToFavorite(vacId)
        }
        tabBarUpdater?.updateTabBar()
    }
    
    @objc
    private func dismiss() {
        viewModel?.dismiss()
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        button.addTarget(
            self,
            action: #selector(dismiss),
            for: .touchUpInside
        )
        
        return button
    }()
    
    private let eyeIconView = UIImageView(
        image: UIImage(named: "eyeIcon")
    )
    
    private let shareIconView = UIImageView(
        image: UIImage(named: "shareIcon")
    )
    
    private lazy var heartIconView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "heartIcon4"))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(handleLikeTap)
            )
        )
        return view
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
        [backButton, eyeIconView, shareIconView, heartIconView
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [backButton, eyeIconView, shareIconView, heartIconView
        ].forEach{ contentView.addSubview($0) }
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            backButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            backButton.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            heartIconView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            heartIconView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            heartIconView.heightAnchor.constraint(equalToConstant: 24),
            heartIconView.widthAnchor.constraint(equalToConstant: 24),
            
            shareIconView.trailingAnchor.constraint(
                equalTo: heartIconView.leadingAnchor,
                constant: -1 * spacing
            ),
            shareIconView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            shareIconView.heightAnchor.constraint(equalToConstant: 24),
            shareIconView.widthAnchor.constraint(equalToConstant: 24),
            
            eyeIconView.trailingAnchor.constraint(
                equalTo: shareIconView.leadingAnchor,
                constant: -1 * spacing
            ),
            eyeIconView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            eyeIconView.heightAnchor.constraint(equalToConstant: 28),
            eyeIconView.widthAnchor.constraint(equalToConstant: 28),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
