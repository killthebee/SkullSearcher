import UIKit

protocol BSPresenterDelegate: AnyObject {
    func presentBS()
}

protocol CanUpdateLikesProtocol: AnyObject {
    func updateTabBar()
    func refresh()
}

class MainViewController: UIViewController, BSPresenterDelegate, CanUpdateLikesProtocol {
    
    // MARK: Dependencies -
    var viewModel: MainViewModelProtocol?
    private let delegate = BottomSheetTransitioningDelegate(configuration: .default)
    
    // MARK: Data -
    let offerIcons: [UIImage?] = [
        UIImage(named: "locationIcon2"), UIImage(named: "Star2Icon"),
        UIImage(named: "checkNoteIcon2"), UIImage(named: "locationIcon2")
    ]
    
    var offerTexts: [String] = []
    var vacanciesPreviews: [VacancyPreviewData] = []
    
    // MARK: Logic -
    private func bindUI() {
        viewModel?.refreshCollectionView = { [weak self] in
            self?.collectionView.reloadData()
            let moreButtonString = "Еще \(self?.vacanciesPreviews.count ?? 0) вакансий"
            self?.moreButton.setTitle(moreButtonString, for: .normal)
        }
        
        viewModel?.setOffersTexts = { [weak self] (offerTexts) in
            self?.offerTexts = offerTexts
        }
        
        viewModel?.setVacanciesPreviews = { [weak self] (previews) in
            self?.vacanciesPreviews = previews
        }
        
        viewModel?.updateTabBar = { [weak self] () in
            self?.dashboardTabBar.addItemBadge(atIndex: 1)
        }
    }
    
    @objc
    private func handeMoreButtonTap() {
        viewModel?.presentMoreScreen()
    }
    
    func updateTabBar() {
        viewModel?.updateTabBar?()
    }
    
    func refresh() {
        collectionView.reloadData()
    }
    
    // MARK: UI elements -
    func presentBS() {
        let vc = ApplyBSViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = delegate
        present(vc, animated: true)
    }
    
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout.init()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            TopSearchCell.self,
            forCellWithReuseIdentifier: TopSearchCell.cellIdentifier
        )
        
        collectionView.register(
            OfferCell.self,
            forCellWithReuseIdentifier: OfferCell.cellIdentifier
        )
        
        collectionView.register(
            VacanciesSupCell.self,
            forSupplementaryViewOfKind: "VacanciesHeader",
            withReuseIdentifier: VacanciesSupCell.cellIdentifier
        )
        
        collectionView.register(
            VacancyCell.self,
            forCellWithReuseIdentifier: VacancyCell.cellIdentifier
        )
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = lightBlue
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = buttonText1Font
        button.addTarget(
            self,
            action: #selector(handeMoreButtonTap),
            for: .touchDown
        )
        
        return button
    }()
    
    private let dashboardTabBar = DasboardTabBar()
    
    // MARK: View setup -
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .black
        dashboardTabBar.presenter = viewModel as? LikesPresenterProtocol
        disableAutoresizing()
        addSubview()
        configureLayout()
        configureCompositionalLayout()
        bindUI()
        updateUI()
    }
    
    private func updateUI() {
        viewModel?.setData()
    }
    
    private func disableAutoresizing() {
        [collectionView, dashboardTabBar, moreButton
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubview() {
        [collectionView, dashboardTabBar, moreButton
        ].forEach{ view.addSubview($0) }
    }
    
    // MARK: Layout -
    private func configureLayout() {
        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -150
            ),
            
            dashboardTabBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: -2
            ),
            dashboardTabBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: 2
            ),
            dashboardTabBar.heightAnchor.constraint(equalToConstant: 100),
            dashboardTabBar.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            
            moreButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            moreButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            moreButton.heightAnchor.constraint(equalToConstant: 48),
            moreButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -104
            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dashboardTabBar.addItemBadge(atIndex: 1)
    }
}

extension MainViewController {
    
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            if sectionIndex == 0 {
                return MainVCLayouts.shared.searchFilterLayouts()
            } else if sectionIndex == 1 {
                return MainVCLayouts.shared.offersLayouts()
            } else {
                return MainVCLayouts.shared.vacanciesLayouts()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
