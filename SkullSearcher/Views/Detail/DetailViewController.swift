import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Dependencies -
    var viewModel: detailViewModelProtocol?
    
    // MARK: Data -
    let statisticsIcons: [UIImage?] = [
        UIImage(named: "profileIcon2"), UIImage(named: "eyeIcon"),
    ]
    
    var vacancyFullData: VacancyFullData?
    
    // MARK: Logic -
    private func bindUI() {
        viewModel?.setVacancyFullData = { [weak self] (vacancyFullData) in
            self?.vacancyFullData = vacancyFullData
        }
    }
    
    // MARK: UI elements -
    private lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewFlowLayout.init()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            TopHeaderCell.self,
            forCellWithReuseIdentifier: TopHeaderCell.cellIdentifier
        )

        collectionView.register(
            MainInfoCell.self,
            forCellWithReuseIdentifier: MainInfoCell.cellIdentifier
        )

        collectionView.register(
            StatisticsCell.self,
            forCellWithReuseIdentifier: StatisticsCell.cellIdentifier
        )

        collectionView.register(
            CompanyAndAddressCell.self,
            forCellWithReuseIdentifier: CompanyAndAddressCell.cellIdentifier
        )

        collectionView.register(
            AboutCell.self,
            forCellWithReuseIdentifier: AboutCell.cellIdentifier
        )
        collectionView.register(
            questionsCell.self,
            forCellWithReuseIdentifier: questionsCell.cellIdentifier
        )

        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    private let dashboardTabBar = DasboardTabBar.shared
    
    // MARK: View setup -
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .black
        bindUI()
        updateUI()
        disableAutoresizing()
        addSubview()
        configureLayout()
        configureCompositionalLayout()
    }
    
    private func updateUI() {
        viewModel?.makeVacancyData()
    }
    
    private func disableAutoresizing() {
        [collectionView, dashboardTabBar
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubview() {
        [collectionView, dashboardTabBar
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
                equalTo: view.bottomAnchor
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
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dashboardTabBar.addItemBadge(atIndex: 1)
    }
}

extension DetailViewController {
    
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            if sectionIndex == 0 {
                return DetailVCLayouts.shared.topHeaderLayouts()
            } else if sectionIndex == 1 {
                return DetailVCLayouts.shared.mainInfoLayouts()
            } else if sectionIndex == 2 {
                return DetailVCLayouts.shared.statisticsLayouts()
            } else if sectionIndex == 3 {
                return DetailVCLayouts.shared.comopanyAndAddressLayouts()
            } else if sectionIndex == 4 {
                return DetailVCLayouts.shared.aboutLayouts()
            } else {
                return DetailVCLayouts.shared.questionsLayouts()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
