import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModelProtocol?
    var warningFired = false
    
    private func bindUI() {
        viewModel?.showEmailWarning = { [weak self] in
            self?.emailFeld.layer.borderWidth = 2
            self?.emailHelpTextLable.isHidden = false
            self?.warningFired = true
        }
        viewModel?.hideEmailWarning = { [weak self] in
            self?.emailFeld.layer.borderWidth = 0
            self?.emailHelpTextLable.isHidden = true
            self?.warningFired = false
        }
    }
    
    @objc
    private func handleEmailInput() {
        viewModel?.handleEmailInput(emailFeld.text)
    }
    
    func activateButton() {
        continueButton.addTarget(
            self,
            action: #selector(handleEmailInput),
            for: .touchDown
        )
        continueButton.backgroundColor = lightBlue
        continueButton.setTitleColor(.white, for: .normal)
    }
    
    func deactivateButton() {
        continueButton.removeTarget(
            self,
            action: #selector(handleEmailInput),
            for: .touchDown
        )
        continueButton.backgroundColor = darkBlue
        continueButton.setTitleColor(grey4, for: .normal)
    }
    
    private let enterLKLable: UILabel = {
        let lable = UILabel()
        lable.font = title2Font
        lable.textColor = .white
        lable.text = enterLKString
        
        return lable
    }()
    
    private let jobSearchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = grey2
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let employeeSearchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = grey2
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let jobSearchHeaderLable: UILabel = {
        let lable = UILabel()
        lable.font = title3Font
        lable.textColor = .white
        lable.text = jobSearchString
        
        return lable
    }()
    
    private let emailFeld: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 8
        field.textColor = .white
        field.font = text1Font
        field.layer.borderColor = UIColor.red.cgColor
        field.backgroundColor = grey2
        field.attributedPlaceholder = NSAttributedString(
            string: emailPlaceholderString,
            attributes: [
                NSAttributedString.Key.foregroundColor: grey4!,
                NSAttributedString.Key.font: text1Font!
            ]
        )
        field.dropShadow()
        field.setLeftIcon(UIImage(named: "emailIcon"))
        field.applyCustomClearButton()
        
        return field
    }()
    
    private let emailHelpTextLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .red
        lable.font = title4Font
        lable.text = emailHelpTextString
        lable.isHidden = true
        
        return lable
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = darkBlue
        button.layer.cornerRadius = 8
        button.setTitle(continueString, for: .normal)
        button.setTitleColor(grey4, for: .normal)
        button.titleLabel?.font = buttonText2Font
        
        return button
    }()
    
    private let eneterWithPWButton: UIButton = {
        let button = UIButton()
        button.setTitle(enterWithPWString, for: .normal)
        button.setTitleColor(lightBlue, for: .normal)
        button.titleLabel?.font = buttonText2Font
        
        return button
    }()
    
    private lazy var employeeSearchStack: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [employeeSearchHeaderLable, employeeSearchTextLable]
        )
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        return stack
    }()
    
    private let employeeSearchHeaderLable: UILabel = {
        let lable = UILabel()
        lable.text = employeeSearchHeaderString
        lable.textColor = .white
        lable.font = title3Font
        
        return lable
    }()
    
    private let employeeSearchTextLable: UILabel = {
        let lable = UILabel()
        lable.text = employeeSearchTextString
        lable.textColor = .white
        lable.font = text1Font
        
        return lable
    }()
    
    private let employeeSearchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = green
        button.setTitle(employeeSearchButtonString, for: .normal)
        button.layer.cornerRadius = 16 // 50??
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = buttonText2Font
        
        return button
    }()
    
    private let dashboardTabBar = DasboardTabBar.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .black
        disableAutoresizing()
        addSubview()
        configureLayout()
        emailFeld.delegate = self
        bindUI()
    }
    
    private func disableAutoresizing() {
        [enterLKLable, centerContainerView, jobSearchContainerView,
         employeeSearchContainerView, jobSearchHeaderLable, emailFeld,
         continueButton, eneterWithPWButton, employeeSearchHeaderLable,
         employeeSearchTextLable, employeeSearchButton, employeeSearchStack,
         dashboardTabBar, emailHelpTextLable
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubview() {
        [enterLKLable, centerContainerView, dashboardTabBar
        ].forEach{ view.addSubview($0) }
        [jobSearchContainerView, employeeSearchContainerView,
        ].forEach{ centerContainerView.addSubview($0) }
        [jobSearchHeaderLable, emailFeld, continueButton, eneterWithPWButton,
         emailHelpTextLable,
        ].forEach{ jobSearchContainerView.addSubview($0) }
         [employeeSearchButton, employeeSearchStack
        ].forEach{ employeeSearchContainerView.addSubview($0) }
    }
    
    private let centerContainerView = UIView()
    
    private func configureLayout() {
        let spacing: CGFloat = 16
        let secondSpacing: CGFloat = 24
        let jobSearchContainerHeight: CGFloat = 179
        let employeeSearchContainerHeight: CGFloat = 141
        
        let constraints: [NSLayoutConstraint] = [
            enterLKLable.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 64
            ),
            enterLKLable.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: spacing
            ),
            enterLKLable.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            
            centerContainerView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            centerContainerView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor
            ),
            centerContainerView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: spacing
            ),
            centerContainerView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -1 * spacing
            ),
            centerContainerView.heightAnchor.constraint(
                equalToConstant: (
                    spacing + jobSearchContainerHeight
                    + employeeSearchContainerHeight
                )
            ),
            
            jobSearchContainerView.topAnchor.constraint(
                equalTo: centerContainerView.topAnchor
            ),
            jobSearchContainerView.leadingAnchor.constraint(
                equalTo: centerContainerView.leadingAnchor
            ),
            jobSearchContainerView.trailingAnchor.constraint(
                equalTo: centerContainerView.trailingAnchor
            ),
            jobSearchContainerView.heightAnchor.constraint(
                equalToConstant: jobSearchContainerHeight
            ),
            
            employeeSearchContainerView.topAnchor.constraint(
                equalTo: jobSearchContainerView.bottomAnchor,
                constant: spacing
            ),
            employeeSearchContainerView.leadingAnchor.constraint(
                equalTo: centerContainerView.leadingAnchor
            ),
            employeeSearchContainerView.trailingAnchor.constraint(
                equalTo: centerContainerView.trailingAnchor
            ),
            employeeSearchContainerView.heightAnchor.constraint(
                equalToConstant: employeeSearchContainerHeight
            ),
            
            jobSearchHeaderLable.topAnchor.constraint(
                equalTo: jobSearchContainerView.topAnchor,
                constant: secondSpacing
            ),
            jobSearchHeaderLable.leadingAnchor.constraint(
                equalTo: jobSearchContainerView.leadingAnchor,
                constant: spacing
            ),
            jobSearchHeaderLable.trailingAnchor.constraint(
                equalTo: jobSearchContainerView.trailingAnchor
            ),
            
            emailFeld.topAnchor.constraint(
                equalTo: jobSearchHeaderLable.bottomAnchor,
                constant: spacing
            ),
            emailFeld.leadingAnchor.constraint(
                equalTo: jobSearchContainerView.leadingAnchor,
                constant: spacing
            ),
            emailFeld.trailingAnchor.constraint(
                equalTo: jobSearchContainerView.trailingAnchor,
                constant: -1 * spacing
            ),
            emailFeld.heightAnchor.constraint(equalToConstant: 40),
            
            emailHelpTextLable.topAnchor.constraint(
                equalTo: jobSearchHeaderLable.bottomAnchor
            ),
            emailHelpTextLable.leadingAnchor.constraint(
                equalTo: jobSearchContainerView.leadingAnchor,
                constant: spacing
            ),
            emailHelpTextLable.trailingAnchor.constraint(
                equalTo: jobSearchContainerView.trailingAnchor,
                constant: -1 * spacing
            ),
            emailHelpTextLable.bottomAnchor.constraint(
                equalTo: emailFeld.topAnchor
            ),
            
            continueButton.topAnchor.constraint(
                equalTo: emailFeld.bottomAnchor,
                constant: spacing
            ),
            continueButton.leadingAnchor.constraint(
                equalTo: jobSearchContainerView.leadingAnchor,
                constant: spacing
            ),
            continueButton.widthAnchor.constraint(
                equalTo: emailFeld.widthAnchor,
                multiplier: 0.5
            ),
            continueButton.heightAnchor.constraint(equalToConstant: 40),
            
            eneterWithPWButton.topAnchor.constraint(
                equalTo: emailFeld.bottomAnchor,
                constant: spacing
            ),
            eneterWithPWButton.leadingAnchor.constraint(
                equalTo: continueButton.trailingAnchor,
                constant: spacing
            ),
            eneterWithPWButton.widthAnchor.constraint(
                equalTo: emailFeld.widthAnchor,
                multiplier: 0.5
            ),
            eneterWithPWButton.heightAnchor.constraint(equalToConstant: 40),
            
            employeeSearchStack.topAnchor.constraint(
                equalTo: employeeSearchContainerView.topAnchor,
                constant: secondSpacing
            ),
            employeeSearchStack.leadingAnchor.constraint(
                equalTo: employeeSearchContainerView.leadingAnchor,
                constant: spacing
            ),
            employeeSearchStack.trailingAnchor.constraint(
                equalTo: employeeSearchContainerView.trailingAnchor,
                constant: -1 * spacing
            ),
            employeeSearchStack.heightAnchor.constraint(
                equalToConstant: 45
            ),
            
            employeeSearchButton.topAnchor.constraint(
                equalTo: employeeSearchStack.bottomAnchor,
                constant: spacing
            ),
            employeeSearchButton.leadingAnchor.constraint(
                equalTo: employeeSearchContainerView.leadingAnchor,
                constant: spacing
            ),
            employeeSearchButton.trailingAnchor.constraint(
                equalTo: employeeSearchContainerView.trailingAnchor,
                constant: -1 * spacing
            ),
            employeeSearchButton.heightAnchor.constraint(equalToConstant: 32),
            employeeSearchButton.bottomAnchor.constraint(
                equalTo: employeeSearchContainerView.bottomAnchor,
                constant: -1 * secondSpacing
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

