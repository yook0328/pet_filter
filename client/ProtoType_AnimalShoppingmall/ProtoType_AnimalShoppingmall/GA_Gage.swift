//
//  GA_Gage.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 4. 27..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class GA_Gage: UIView {

    var gage : UIView?
    var fill_gage : UIView?
    
    func setup(_fullValue : CGFloat, _value : CGFloat, _back_gageColor : UIColor, _gageColor : UIColor){
        
        gage = UIView()
        fill_gage = UIView()
        
        gage?.backgroundColor = _gageColor
        fill_gage?.backgroundColor = _back_gageColor
        
        self.addSubview(fill_gage!)
        self.addSubview(gage!)
        
        fill_gage?.translatesAutoresizingMaskIntoConstraints = false
        gage?.translatesAutoresizingMaskIntoConstraints = false
        
        fill_gage?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fill_gage?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fill_gage?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        fill_gage?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
        gage?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        gage?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        gage?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        gage?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: _value/_fullValue).isActive = true
        
    }
    
}
