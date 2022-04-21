import UIKit
import Kingfisher

protocol DetailViewDelegate {
    func handleFavoriteButtonTap(isFavorite: Bool)
}


class DetailView: UIView {
    
    private lazy var scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .myGray
        scrollView.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height + 300)
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .myGray
        view.isAccessibilityElement = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .myGray
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 0.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        return stackView
    }()
    
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let profileContentView: UIView  = {
        let profileView = UIView()
        profileView.backgroundColor = .white
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.layer.shadowColor = UIColor.white.cgColor
        profileView.layer.shadowOpacity = 0.20
        profileView.layer.shadowOffset = .zero
        profileView.layer.shadowRadius = 10
        profileView.layer.cornerRadius = 15
        return profileView
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius =  100
        image.sizeToFit()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemPink
        image.clipsToBounds = true
        return image
    }()
    
    private let profileDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private let specieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let sexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let favButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "star.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .systemYellow
        
        button.layer.shadowColor = UIColor.yellow.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = .zero
        button.layer.shadowRadius = 10
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
    var name: String = "" {
        didSet {
            self.profileLabel.text = self.name.uppercased()
        }
    }
    
    var eldescription: String = "" {
        didSet {
            self.profileDescription.text = self.eldescription
        }
    }

    var specie: String = "" {
        didSet {
            self.specieLabel.text = self.specie
        }
    }
    
    var sex: String = "" {
        didSet {
            self.sexLabel.text = self.sex
        }
    }
    
    var imageUrl: String = "" {
        didSet {
            self.profileImage.kf.setImage(with: URL(string: self.imageUrl.replacingOccurrences(of: "https", with: "http")),
                                          placeholder: UIImage(named: "placeholder"),
                                          options: nil,
                                          completionHandler: nil)
        }
    }
    
    var delegate: DetailViewDelegate?
    var isFavorited: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(){
        super.init(frame: .zero)
        self.buildView()
        self.setupConstraints()
    }
    
    private func buildView(){
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(profileLabel)
        profileContentView.addSubview(profileImage)
        profileContentView.addSubview(profileDescription)
        profileContentView.addSubview(favButton)
        profileContentView.addSubview(specieLabel)
        profileContentView.addSubview(sexLabel)
        stackView.addArrangedSubview(profileContentView)
       
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
      
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            profileLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 40),
            profileLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            profileLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            profileContentView.topAnchor.constraint(equalTo: profileLabel.topAnchor, constant: 20),
            profileContentView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            profileContentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            profileContentView.heightAnchor.constraint(equalToConstant: 430),
            
            profileImage.topAnchor.constraint(equalTo: profileContentView.topAnchor, constant: 16),
            profileImage.leadingAnchor.constraint(equalTo: profileContentView.leadingAnchor, constant: 68),
            profileImage.trailingAnchor.constraint(equalTo: profileContentView.trailingAnchor, constant: -68),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            
            profileDescription.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 16),
            profileDescription.leadingAnchor.constraint(equalTo: profileContentView.leadingAnchor, constant: 16),
            profileDescription.trailingAnchor.constraint(equalTo: profileContentView.trailingAnchor, constant: -16),
            
            specieLabel.topAnchor.constraint(equalTo: profileDescription.bottomAnchor, constant: 32),
            specieLabel.leadingAnchor.constraint(equalTo: profileContentView.leadingAnchor, constant: 16),
            specieLabel.trailingAnchor.constraint(equalTo: profileContentView.trailingAnchor, constant: -16),
            
            sexLabel.topAnchor.constraint(equalTo: specieLabel.bottomAnchor, constant: 16),
            sexLabel.leadingAnchor.constraint(equalTo: profileContentView.leadingAnchor, constant: 16),
            sexLabel.trailingAnchor.constraint(equalTo: profileContentView.trailingAnchor, constant: -16),
            
            favButton.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 16),
            favButton.centerXAnchor.constraint(equalTo: profileContentView.centerXAnchor),
            favButton.heightAnchor.constraint(equalToConstant: 60),
            favButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}

extension DetailView {
    @objc func handleTap(){
        isFavorited.toggle()
        if isFavorited{
            favButton.setImage(UIImage(systemName: "star.circle.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "star.circle"), for: .normal)
        }
        self.delegate?.handleFavoriteButtonTap(isFavorite: isFavorited)
    }
}
