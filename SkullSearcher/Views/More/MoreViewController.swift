import UIKit

class moreViewController: UIViewController {
    
    var viewModel: MoreViewModelProtocol?
    
    var vacanciesPreviews: [VacancyPreviewData] = []
    
    private func bindUI() {
        viewModel?.refreshCollectionView = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel?.setVacanciesPreviews = { [weak self] (previews) in
            self?.vacanciesPreviews = previews
        }
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
            MoreSupCell.self,
            forSupplementaryViewOfKind: "MoreHeader",
            withReuseIdentifier: MoreSupCell.cellIdentifier
        )
        
        collectionView.register(
            VacancyCell.self,
            forCellWithReuseIdentifier: VacancyCell.cellIdentifier
        )
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .black
    }
    
    private func configure() {
        disableAutoresizing()
        addSubview()
        configureLayout()
        configureCompositionalLayout()
        bindUI()
        updateUI()
    }
    
    private let dashboardTabBar = DasboardTabBar.shared
    
    private func updateUI() {
        viewModel?.setVacancies()
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
}

extension moreViewController {
    
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            if sectionIndex == 0 {
                return MoreVCLayouts.shared.searchFilterLayouts()
            } else {
                return MoreVCLayouts.shared.vacanciesLayouts(
                    self.vacanciesPreviews.count
                )
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
