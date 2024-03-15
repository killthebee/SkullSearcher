import UIKit

class ConfirmViewController: UIViewController {
    
    var viewModel: ConfirmViewModelProtocol?
    
    private func bindUI() {
        viewModel?.setSentHeaderText = { [weak self] (header) in
            self?.sentHeaderLable.text = header
        }
    }
    
    private let sentHeaderLable: UILabel = {
        let lable = UILabel()
        lable.font = title2Font
        lable.textColor = .white
        
        return lable
    }()
    
    private let sentTextLable: UILabel = {
        let lable = UILabel()
        lable.text = sentTextString
        lable.font = title3Font
        lable.textColor = .white
        lable.numberOfLines = 0
        
        return lable
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = darkBlue
        button.layer.cornerRadius = 8
        button.setTitle(continueString, for: .normal)
        button.setTitleColor(grey4, for: .normal)
        button.titleLabel?.font = buttonText1Font
        
        return button
    }()
    
    private let codeField1 = CodeField()
    private let codeField2 = CodeField()
    private let codeField3 = CodeField()
    private let codeField4 = CodeField()
    
    private let dashboardTabBar = DasboardTabBar.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        disableAutoresizing()
        addSubview()
        configureLayout()
        bindUI()
        setupUI()
    }
    
    private func setupUI() {
        viewModel?.setSentHeader()
    }
    
    private func disableAutoresizing() {
        [sentHeaderLable, sentTextLable, confirmButton, codeField1, codeField2,
         codeField3, codeField4, dashboardTabBar, containerView
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubview() {
        [dashboardTabBar, containerView].forEach{ view.addSubview($0) }
        [sentHeaderLable, sentTextLable, confirmButton, codeField1, codeField2,
         codeField3, codeField4,
        ].forEach{ containerView.addSubview($0) }
    }
    
    private let containerView = UIView()
    
    private func configureLayout() {
        let spacing: CGFloat = 12
        let secondSpacing: CGFloat = 24
        let thirdSpacing: CGFloat = 16
        let codeSpacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            containerView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 161
            ),
            containerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: spacing
            ),
            containerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -1 * spacing
            ),
            containerView.heightAnchor.constraint(
                equalToConstant: 225
            ),
            
            sentHeaderLable.topAnchor.constraint(
                equalTo: containerView.topAnchor
            ),
            sentHeaderLable.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            sentHeaderLable.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            sentHeaderLable.heightAnchor.constraint(
                equalToConstant: 24
            ),
            
            sentTextLable.topAnchor.constraint(
                equalTo: sentHeaderLable.bottomAnchor,
                constant: secondSpacing
            ),
            sentTextLable.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            sentTextLable.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            sentTextLable.heightAnchor.constraint(
                equalToConstant: 57
            ),
            
            codeField1.topAnchor.constraint(
                equalTo: sentTextLable.bottomAnchor,
                constant: thirdSpacing
            ),
            codeField1.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            codeField1.widthAnchor.constraint(
                equalToConstant: 48
            ),
            codeField1.heightAnchor.constraint(
                equalToConstant: 48
            ),
            
            codeField2.topAnchor.constraint(
                equalTo: sentTextLable.bottomAnchor,
                constant: thirdSpacing
            ),
            codeField2.leadingAnchor.constraint(
                equalTo: codeField1.trailingAnchor,
                constant: codeSpacing
            ),
            codeField2.widthAnchor.constraint(
                equalToConstant: 48
            ),
            codeField2.heightAnchor.constraint(
                equalToConstant: 48
            ),
            
            codeField3.topAnchor.constraint(
                equalTo: sentTextLable.bottomAnchor,
                constant: thirdSpacing
            ),
            codeField3.leadingAnchor.constraint(
                equalTo: codeField2.trailingAnchor,
                constant: codeSpacing
            ),
            codeField3.widthAnchor.constraint(
                equalToConstant: 48
            ),
            codeField3.heightAnchor.constraint(
                equalToConstant: 48
            ),
            
            codeField4.topAnchor.constraint(
                equalTo: sentTextLable.bottomAnchor,
                constant: thirdSpacing
            ),
            codeField4.leadingAnchor.constraint(
                equalTo: codeField3.trailingAnchor,
                constant: codeSpacing
            ),
            codeField4.widthAnchor.constraint(
                equalToConstant: 48
            ),
            codeField4.heightAnchor.constraint(
                equalToConstant: 48
            ),
            
            confirmButton.topAnchor.constraint(
                equalTo: codeField4.bottomAnchor,
                constant: thirdSpacing
            ),
            confirmButton.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor
            ),
            confirmButton.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor
            ),
            confirmButton.heightAnchor.constraint(
                equalToConstant: 48
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
