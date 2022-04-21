//
//  ElephantCollectionViewCell.swift
//  elephants
//
//  Created by c94292a on 19/04/22.
//

import UIKit

class ElephantCollectionViewCell: UICollectionViewCell {
    
    private lazy var view: UIView = {
        let view = UIView(frame: contentView.bounds)
        view.backgroundColor = .red
        return view
    }()
    
    init(){
        super.init(frame: .zero)
        contentView.addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
