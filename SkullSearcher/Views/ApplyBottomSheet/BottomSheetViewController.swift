import UIKit

final class ExampleViewController: UIViewController {
    
    private let avatarIconCoverImageView = UIImageView(
        image: UIImage(named: "avatarImage")
    )
    
    private let cvHelpTextLable: UILabel = {
        let lable = UILabel()
        lable.text = "Резюме для отклика"
        lable.font = text1Font
        lable.textColor = grey3
        
        return lable
    }()
    
    private let cvLable: UILabel = {
        let lable = UILabel()
        lable.text = "UI/UX дизайнер"
        lable.font = title3Font
        lable.textColor = .white
        
        return lable
    }()
    
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = green
        button.layer.cornerRadius = 8
        button.setTitle(applyString, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = buttonText1Font
//        button.addTarget(
//            self, action: #selector(applyToVacancy),
//            for: .touchUpInside
//        )
        
        return button
    }()
    
    private lazy var addCoverLetterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить сопроводительное", for: .normal)
        button.setTitleColor(green, for: .normal)
        button.titleLabel?.font = buttonText1Font
//        button.addTarget(
//            self, action: #selector(applyToVacancy),
//            for: .touchUpInside
//        )
        
        return button
    }()
    
    private let litteralyLine: UIView = {
        let view = UIView()
        view.backgroundColor = grey2
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        disableAutoresizing()
        addSubviews()
        setUpConstrains()
    }
    
    private func disableAutoresizing() {
        [cvHelpTextLable, cvLable, applyButton, addCoverLetterButton,
         litteralyLine, avatarIconCoverImageView
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [cvHelpTextLable, cvLable, applyButton, addCoverLetterButton,
         litteralyLine, avatarIconCoverImageView
        ].forEach{ view.addSubview($0) }
        
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 16
        
        let constraints: [NSLayoutConstraint] = [
            avatarIconCoverImageView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 45
            ),
            avatarIconCoverImageView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: spacing
            ),
            avatarIconCoverImageView.widthAnchor.constraint(
                equalToConstant: 48
            ),
            avatarIconCoverImageView.heightAnchor.constraint(
                equalToConstant: 48
            ),
            
            cvHelpTextLable.topAnchor.constraint(
                equalTo: avatarIconCoverImageView.topAnchor,
                constant: 2
            ),
            cvHelpTextLable.leadingAnchor.constraint(
                equalTo: avatarIconCoverImageView.trailingAnchor,
                constant: spacing
            ),
            cvHelpTextLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            cvLable.bottomAnchor.constraint(
                equalTo: avatarIconCoverImageView.bottomAnchor,
                constant: -2
            ),
            cvLable.leadingAnchor.constraint(
                equalTo: avatarIconCoverImageView.trailingAnchor,
                constant: spacing
            ),
            cvLable.heightAnchor.constraint(
                equalToConstant: 17
            ),
            
            litteralyLine.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 117
            ),
            litteralyLine.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: spacing
            ),
            litteralyLine.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -1 * spacing
            ),
            litteralyLine.heightAnchor.constraint(
                equalToConstant: 1
            ),
            
            applyButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: -1 * spacing
            ),
            applyButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: spacing
            ),
            
            applyButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -1 * spacing
            ),
            applyButton.heightAnchor.constraint(equalToConstant: 48),
            
            addCoverLetterButton.bottomAnchor.constraint(
                equalTo: applyButton.topAnchor,
                constant: -1 * spacing
            ),
            addCoverLetterButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: spacing
            ),
            
            addCoverLetterButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -1 * spacing
            ),
            addCoverLetterButton.heightAnchor.constraint(equalToConstant: 21),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

