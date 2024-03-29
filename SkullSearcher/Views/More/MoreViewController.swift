import UIKit

class MoreViewController: UIViewController, BSPresenterDelegate, CanUpdateLikesProtocol {
 
    // MARK: Dependencies -
    var viewModel: MoreViewModelProtocol?
    private let delegate = BottomSheetTransitioningDelegate(configuration: .default)
    weak var mainVCDelegate: CanUpdateLikesProtocol?
    
    // MARK: Data -
    var vacanciesPreviews: [VacancyPreviewData] = []
    var favorites = Set<String>()
    
    // MARK: Logic -
    private func bindUI() {
        viewModel?.refreshCollectionView = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel?.setVacanciesPreviews = { [weak self] (previews) in
            self?.vacanciesPreviews = previews
        }
        
        viewModel?.setFavorites = { [weak self] (favorites) in
            self?.favorites = favorites
        }
        
        viewModel?.updateTabBar = { [weak self] () in
            self?.dashboardTabBar.addItemBadge(atIndex: 1)
        }
        viewModel?.updateParent = { [weak self] () in
            self?.mainVCDelegate?.updateTabBar()
            self?.mainVCDelegate?.refresh()
        }
    }
    
    func presentBS() {
        let vc = ApplyBSViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = delegate
        present(vc, animated: true)
    }
    
    func updateTabBar() {
        viewModel?.updateTabBar?()
    }
    
    func refresh() {
        collectionView.reloadData()
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
    
    private let dashboardTabBar = DasboardTabBar()
    
    // MARK: View setup -
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        view.backgroundColor = .black
    }
    
    private func configure() {
        disableAutoresizing()
        addSubview()
        dashboardTabBar.presenter = viewModel as? LikesPresenterProtocol
        configureLayout()
        configureCompositionalLayout()
        bindUI()
        updateUI()
    }
    
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
    
    // MARK: Logic -
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
                constant: -110
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

extension MoreViewController {
    
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
