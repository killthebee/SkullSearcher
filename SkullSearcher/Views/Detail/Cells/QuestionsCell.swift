import UIKit

class questionsCell: UICollectionViewCell {
    
    static let cellIdentifier = "QuestionsCellIdentifier"
    
    private let callLable: UILabel = {
        let lable = UILabel()
        lable.text = "Задайте вопрос работодателю"
        lable.font = title4Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let callHelpLable: UILabel = {
        let lable = UILabel()
        lable.text = "Он получит его с откликом на вакансию"
        lable.font = title4Font
        lable.textColor = grey3
        
        return lable
    }()
    
    private let textSpacing: String = "     "
    private let exmapleQuestion1: UIButton = {
        let button = UIButton()
        button.backgroundColor = grey2
        button.setTitle("     сколько у вас эникейщиков?!    ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    private let exmapleQuestion2: UIButton = {
        let button = UIButton()
        button.backgroundColor = grey2
        button.setTitle("     сколько у вас эникейщиков?!    ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    private let exmapleQuestion3: UIButton = {
        let button = UIButton()
        button.backgroundColor = grey2
        button.setTitle("     сколько у вас эникейщиков?!    ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    private let exmapleQuestion4: UIButton = {
        let button = UIButton()
        button.backgroundColor = grey2
        button.setTitle("     сколько у вас эникейщиков?!    ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    private lazy var questionsStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [exmapleQuestion1, exmapleQuestion2, exmapleQuestion3, exmapleQuestion4]
        )
        let constraints: [NSLayoutConstraint] = [
            exmapleQuestion1.heightAnchor.constraint(equalToConstant: 32),
            exmapleQuestion2.heightAnchor.constraint(equalToConstant: 32),
            exmapleQuestion3.heightAnchor.constraint(equalToConstant: 32),
            exmapleQuestion4.heightAnchor.constraint(equalToConstant: 32),
        ]

        NSLayoutConstraint.activate(constraints)
//        let stack = UIStackView()
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
        [exmapleQuestion1, exmapleQuestion2, exmapleQuestion3, exmapleQuestion4
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
//        [callLable, callHelpLable,
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
//            questionsStack.heightAnchor.constraint(
//                equalToConstant: 156
//            ),
            questionsStack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10 * spacing
            )
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

