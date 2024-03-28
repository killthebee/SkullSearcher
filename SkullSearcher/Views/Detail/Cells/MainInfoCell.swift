import UIKit

class MainInfoCell: UICollectionViewCell {
    
    static let cellIdentifier = "MainInfoCellIdentifier"
    
    func configure(_ vacancy: VacancyFullData?) {
        guard let vacancy = vacancy else { return }
        titleLable.text = vacancy.title
        salaryLable.text = vacancy.salary
        expLable.text = vacancy.experience
        schedulesLable.text = vacancy.schedules
    }
    
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.text = "UI/UX Designer"
        lable.font = title1Font
        lable.textColor = .white
        
        return lable
    }()
    
    let salaryLable: UILabel = {
        let lable = UILabel()
        lable.text = "Уровень дохода не указанr"
        lable.font = text1Font
        lable.textColor = .white
        
        return lable
    }()
    
    let expLable: UILabel = {
        let lable = UILabel()
        lable.text = "Требуемый опыт: от 1 года до 3 лет"
        lable.font = text1Font
        lable.textColor = .white
        
        return lable
    }()
    
    let schedulesLable: UILabel = {
        let lable = UILabel()
        lable.text = "Полная занятость, полный день"
        lable.font = text1Font
        lable.textColor = .white
        
        return lable
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
        [titleLable, salaryLable, expLable, schedulesLable
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [titleLable, salaryLable, expLable, schedulesLable
        ].forEach{ contentView.addSubview($0) }
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 16
        let spacing2: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            titleLable.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            titleLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            titleLable.heightAnchor.constraint(equalToConstant: 26),
            
            salaryLable.topAnchor.constraint(
                equalTo: titleLable.bottomAnchor,
                constant: spacing
            ),
            salaryLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            salaryLable.heightAnchor.constraint(equalToConstant: 17),
            
            expLable.topAnchor.constraint(
                equalTo: salaryLable.bottomAnchor,
                constant: spacing
            ),
            expLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            expLable.heightAnchor.constraint(equalToConstant: 17),
            
            schedulesLable.topAnchor.constraint(
                equalTo: expLable.bottomAnchor,
                constant: spacing2
            ),
            schedulesLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            schedulesLable.heightAnchor.constraint(equalToConstant: 17),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

