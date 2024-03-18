import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelProtocol?
    
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
    
    private let morButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = lightBlue
        button.layer.cornerRadius = 8
        button.setTitle(moreString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = buttonText1Font
        
        return button
    }()
    
    private let dashboardTabBar = DasboardTabBar.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .black
        disableAutoresizing()
        addSubview()
        configureLayout()
        configureCompositionalLayout()
    }
    
    private func disableAutoresizing() {
        [collectionView, dashboardTabBar, morButton
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubview() {
        [collectionView, dashboardTabBar, morButton
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
            
            morButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            morButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            morButton.heightAnchor.constraint(equalToConstant: 48),
            morButton.bottomAnchor.constraint(
                equalTo: dashboardTabBar.topAnchor,
                constant: -4
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
