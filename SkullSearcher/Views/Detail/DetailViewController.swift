import UIKit

class detailViewController: UIViewController {
    
    var viewModel: detailViewModelProtocol?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
//        viewModel?.makeVacancyData()
    }
    
    private func configure() {
        view.backgroundColor = .black
        disableAutoresizing()
        addSubview()
        configureLayout()
        configureCompositionalLayout()
//        bindUI()
//        updateUI()
    }
    
    private func disableAutoresizing() {
        [collectionView, dashboardTabBar
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubview() {
        [collectionView, dashboardTabBar
        ].forEach{ view.addSubview($0) }
    }
    
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

extension detailViewController {
    
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            if sectionIndex == 0 {
                return detailVCLayouts.shared.topHeaderLayouts()
            } else if sectionIndex == 1 {
                return detailVCLayouts.shared.mainInfoLayouts()
            } else if sectionIndex == 2 {
                return detailVCLayouts.shared.statisticsLayouts()
            } else if sectionIndex == 3 {
                return detailVCLayouts.shared.comopanyAndAddressLayouts()
            } else if sectionIndex == 4 {
                return detailVCLayouts.shared.aboutLayouts()
            } else {
                return detailVCLayouts.shared.questionsLayouts()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
