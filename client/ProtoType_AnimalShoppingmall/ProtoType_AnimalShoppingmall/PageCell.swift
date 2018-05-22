//
//  PageCell.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 21..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class PageCell: BaseCell {
    
    var page : UIView? {
        didSet {
//            page?.translatesAutoresizingMaskIntoConstraints = false
//            page?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//            page?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//            page?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//            page?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            page?.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            addSubview(page!)
        }
    }
    
    override func setupViews() {
        
    }
}
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
