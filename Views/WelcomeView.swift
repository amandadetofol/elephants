import Foundation
import UIKit
import Kingfisher

protocol WelcomeViewDelegate {
    func handleLetsGetStartedButtonTap()
}

class WelcomeView: UIView {
    
    private lazy var scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.myGray
        scrollView.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height )
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor.myGray
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 0.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isAccessibilityElement = false
        return stackView
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius =  150
        image.sizeToFit()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemPink
        image.clipsToBounds = true
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome!"
        label.font = .boldSystemFont(ofSize: 28)
        label.textAlignment = .left
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This application is for elephant lovers, just like you."
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let's get started", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var delegate: WelcomeViewDelegate?
    
    init(){
        super.init(frame: .zero)
        self.buildView()
        self.setupConstraints()
    }
    
    // MARK: Private funcs
    private func buildView(){
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(button)
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
            
            image.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 100),
            image.widthAnchor.constraint(equalToConstant: 300),
            image.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -32),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 32),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -32),
            
            button.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            button.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: 32),
            button.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor, constant: -32),
            button.heightAnchor.constraint(equalToConstant: 48),
            button.bottomAnchor.constraint(equalTo: self.stackView.bottomAnchor)
        ])
           
    }
}

extension WelcomeView {
    @objc func handleTap(){
        self.delegate?.handleLetsGetStartedButtonTap()
    }
}
