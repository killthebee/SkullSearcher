import UIKit

class MainInfoCell: UICollectionViewCell {
    
    static let cellIdentifier = "MainInfoCellIdentifier"
    
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.text = "UI/UX Designer"
        lable.font = title1Font
        lable.textColor = .white
        
        return lable
    }()
    
    let slaryLable: UILabel = {
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
    
    private lazy var schedulesExpStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [expLable, schedulesLable]
        )
        
        stack.axis = .vertical
        stack.spacing = 8
        
        return stack
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
        [titleLable, slaryLable, schedulesExpStack
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [titleLable, slaryLable, schedulesExpStack
        ].forEach{ contentView.addSubview($0) }
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 16
        
        let constraints: [NSLayoutConstraint] = [
            titleLable.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            titleLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            titleLable.heightAnchor.constraint(equalToConstant: 26),
            
            slaryLable.topAnchor.constraint(
                equalTo: titleLable.bottomAnchor,
                constant: spacing
            ),
            slaryLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            slaryLable.heightAnchor.constraint(equalToConstant: 17),
            
            schedulesExpStack.topAnchor.constraint(
                equalTo: slaryLable.bottomAnchor,
                constant: spacing
            ),
            schedulesExpStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            schedulesExpStack.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

