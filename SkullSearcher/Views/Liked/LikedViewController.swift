import UIKit

class LikedViewController: UIViewController, BSPresenterDelegate, CanUpdateLikesProtocol {
    
    // MARK: Dependencies -
    var viewModel: LikedViewModelProtocol?
    private let delegate = BottomSheetTransitioningDelegate(configuration: .default)
    weak var parentVCDelegate: CanUpdateLikesProtocol?
    
    // MARK: Data -
    var vacanciesPreviews: [VacancyPreviewData] = []
    
    // MARK: Logic -
    private func bindUI() {
        viewModel?.refreshCollectionView = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel?.setVacanciesPreviews = { [weak self] (previews) in
            self?.vacanciesPreviews = previews
        }
        
        viewModel?.updateLable = { [weak self] in
            self?.vacanciesCountLable.text = makeVacanciesCount(
                self?.vacanciesPreviews.count ?? 0
            )
        }
        
        viewModel?.updateParent = { [weak self] () in
            self?.parentVCDelegate?.updateTabBar()
            self?.parentVCDelegate?.refresh()
        }
        
        viewModel?.updateTabBar = { [weak self] () in
            self?.dashboardTabBar.addItemBadge(atIndex: 1)
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
    
    func dismissLikesVC() {
        viewModel?.dismiss()
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
            VacancyCell.self,
            forCellWithReuseIdentifier: VacancyCell.cellIdentifier
        )
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    private let LikedHeaderLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = title2Font
        lable.text = likedHeaderString
        
        return lable
    }()
    
    private let vacanciesCountLable: UILabel = {
        let lable = UILabel()
        lable.textColor = grey3
        lable.font = text1Font
        lable.text = "2 вакансии"
            
        return lable
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
        configureLayout()
        configureCompositionalLayout()
        dashboardTabBar.dismisser = self
        bindUI()
        updateUI()
    }
    
    private func updateUI() {
        viewModel?.setVacancies()
    }
    
    private func disableAutoresizing() {
        [collectionView, dashboardTabBar, LikedHeaderLable,
         vacanciesCountLable
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubview() {
        [collectionView, dashboardTabBar, LikedHeaderLable,
         vacanciesCountLable
        ].forEach{ view.addSubview($0) }
    }
    
    // MARK: Logic -
    private func configureLayout() {
        
        let constraints: [NSLayoutConstraint] = [
            LikedHeaderLable.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 64
            ),
            LikedHeaderLable.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            LikedHeaderLable.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            LikedHeaderLable.heightAnchor.constraint(
                equalToConstant: 24
            ),
            
            vacanciesCountLable.topAnchor.constraint(
                equalTo: LikedHeaderLable.bottomAnchor,
                constant: 16
            ),
            vacanciesCountLable.leadingAnchor.constraint(
                equalTo: LikedHeaderLable.leadingAnchor
            ),
            vacanciesCountLable.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            vacanciesCountLable.heightAnchor.constraint(
                equalToConstant: 24
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
            
            collectionView.topAnchor.constraint(
                equalTo: vacanciesCountLable.bottomAnchor
            ),
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
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dashboardTabBar.addItemBadge(atIndex: 1)
    }
}

extension LikedViewController {
    
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,enviroment in
            return LikedVCLayouts.shared.vacanciesLayouts(
                self.vacanciesPreviews.count
            )
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
}
