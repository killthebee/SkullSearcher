import UIKit

class questionsCell: UICollectionViewCell {
    
    static let cellIdentifier = "QuestionsCellIdentifier"
    
    func configure(_ vacancy: VacancyFullData?) {
        guard let vacancy = vacancy else { return }
        let numOfQuestion = vacancy.questions.count
        let stackHeight: CGFloat = (
            CGFloat(numOfQuestion * 32) + CGFloat((numOfQuestion) * 8)
        )
        let bottomSpacing: CGFloat = 130
        let cellHeight: CGFloat = 17 + 8 + 17 + 8 + stackHeight + bottomSpacing
        cellHeightAnchor.constant = cellHeight
        for question in vacancy.questions {
            let view = UIView()
            let flexSpace = UIView()
            
            let button = UIButton()
            button.backgroundColor = grey2
            button.setTitle("     \(question)    ", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 16
            button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            button.setContentCompressionResistancePriority(.required, for: .horizontal)
            
            view.addSubview(button)
            view.addSubview(flexSpace)
            
            [view, flexSpace, button
            ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: 32),
                button.topAnchor.constraint(equalTo: view.topAnchor),
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                flexSpace.topAnchor.constraint(equalTo: view.topAnchor),
                flexSpace.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                flexSpace.leadingAnchor.constraint(equalTo: button.trailingAnchor),
            ])
            questionsStack.addArrangedSubview(view)
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
        stack.distribution = .fill
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
        [questionsStack, callLable, callHelpLable, coverView
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        contentView.addSubview(coverView)
        [questionsStack, callLable, callHelpLable,
        ].forEach{ coverView.addSubview($0) }
    }
    
    private let coverView = UIView()
    private lazy var cellHeightAnchor = coverView.heightAnchor.constraint(
        equalToConstant: 286
    )
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            coverView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            coverView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            coverView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            coverView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            cellHeightAnchor,
            
            callLable.topAnchor.constraint(
                equalTo: coverView.topAnchor
            ),
            callLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor
            ),
            callLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            callHelpLable.topAnchor.constraint(
                equalTo: callLable.bottomAnchor,
                constant: spacing
            ),
            callHelpLable.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor
            ),
            callHelpLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            questionsStack.topAnchor.constraint(
                equalTo: callHelpLable.bottomAnchor,
                constant: spacing
            ),
            questionsStack.leadingAnchor.constraint(
                equalTo: coverView.leadingAnchor
            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

