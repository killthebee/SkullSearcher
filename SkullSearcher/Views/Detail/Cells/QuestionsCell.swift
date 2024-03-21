import UIKit

class questionsCell: UICollectionViewCell {
    
    static let cellIdentifier = "QuestionsCellIdentifier"
    
    func configure(_ vacancy: VacancyFullData?) {
        guard let vacancy = vacancy else { return }
        for question in vacancy.questions {
            let button = UIButton()
            button.backgroundColor = grey2
            button.setTitle("     \(question)    ", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 16
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(
                equalToConstant: button.intrinsicContentSize.width
            ).isActive = true
            button.setContentHuggingPriority(UILayoutPriority(1001), for: .horizontal)
            questionsStack.addArrangedSubview(button)
        }
    }
    
    private let callLable: UILabel = {
        let lable = UILabel()
        lable.text = questionHeaderString
        lable.font = title4Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let callHelpLable: UILabel = {
        let lable = UILabel()
        lable.text = questionHelpTextString
        lable.font = title4Font
        lable.textColor = grey3
        
        return lable
    }()
    
    private let textSpacing: String = "     "
   
    private lazy var questionsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
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
        [questionsStack, callLable, callHelpLable,
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [questionsStack, callLable, callHelpLable,
        ].forEach{ contentView.addSubview($0) }
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            callLable.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            callLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            callLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            callHelpLable.topAnchor.constraint(
                equalTo: callLable.bottomAnchor,
                constant: spacing
            ),
            callHelpLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            callHelpLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            questionsStack.topAnchor.constraint(
                equalTo: callHelpLable.bottomAnchor,
                constant: spacing
            ),
            questionsStack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            questionsStack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            questionsStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10 * spacing
            )
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

