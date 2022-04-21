import Foundation
import UIKit

class BottomHomeViewControllerCardView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Curiosity"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "An elephant eats 125 kilograms of plants, grass and foliage, and drinks 200 liters of water a day. Its trunk sucks up 10 liters of water at once."
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(){
        super.init(frame: .zero)
        self.buildView()
        self.setupConstraints()
    }
    
    //MARK: Private funcs
    private func buildView(){
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
    }
    
}


