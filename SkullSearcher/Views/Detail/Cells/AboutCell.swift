import UIKit

class AboutCell: UICollectionViewCell {
    
    static let cellIdentifier = "AboutCellIdentifier"
    
    let aboutCompanyLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = text1Font
        lable.numberOfLines = 0
        lable.text = "MOBYRIX - динамично развивающаяся продуктовая IT-компания, специализирующаяся на разработке мобильных приложений для iOS и Android. Наша команда работает над собственными продуктами в разнообразных сферах: от утилит до развлечений и бизнес-приложений. Мы ценим талант и стремление к инновациям и в данный момент в поиске талантливого UX/UI Designer, готового присоединиться к нашей команде и внести значимый вклад в развитие наших проектов."
        
        return lable
    }()
    
    let titleLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = title3Font
        lable.text = "Ваши задачи"
        
        return lable
    }()
    
    let responsobilityLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = text1Font
        lable.numberOfLines = 0
        lable.text = "-Проектировать пользовательский опыт, проводить UX исследования; -Разрабатывать адаптивный дизайн интерфейса для мобильных приложений; -Разрабатывать быстрые прототипы для тестирования идеи дизайна и их последующая; интеграция на основе обратной связи от команды и пользователей; -Взаимодействовать с командой разработчиков для обеспечения точной реализации ваших дизайнов; -Анализ пользовательского опыта и адаптация под тренды."
        
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
        [aboutCompanyLable, titleLable, responsobilityLable
        ].forEach{ $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func addSubviews() {
        [aboutCompanyLable, titleLable, responsobilityLable
        ].forEach{contentView.addSubview($0)}
    }
    
    private func setUpConstrains() {
        let spacing: CGFloat = 8
        
        let constraints: [NSLayoutConstraint] = [
            aboutCompanyLable.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            aboutCompanyLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            aboutCompanyLable.heightAnchor.constraint(
                equalToConstant: 187
            ),
            aboutCompanyLable.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            titleLable.topAnchor.constraint(
                equalTo: aboutCompanyLable.bottomAnchor,
                constant: spacing
            ),
            titleLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            titleLable.heightAnchor.constraint(
                equalToConstant: 24
            ),
            titleLable.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            
            responsobilityLable.topAnchor.constraint(
                equalTo: titleLable.bottomAnchor,
                constant: spacing
            ),
            responsobilityLable.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            responsobilityLable.heightAnchor.constraint(
                equalToConstant: 204
            ),
            responsobilityLable.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

