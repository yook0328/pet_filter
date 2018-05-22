//
//  UIButtonCollectionViewCell.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 17..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class UIButtonCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var iconLabel: UILabel!
    


    
    func setText(_text : String){
        iconLabel.text = _text
        iconLabel.textColor = UIColor.white
        
    }
}
