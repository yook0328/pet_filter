//
//  RefreshFooterView.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 4. 25..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class RefreshFooterView : UIView {
    var refreshControlIndicator: UIActivityIndicatorView?
    
    var isAnimatingFinal : Bool = false
    var currentTransform : CGAffineTransform?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    func setup(){
        refreshControlIndicator = UIActivityIndicatorView()
        refreshControlIndicator?.hidesWhenStopped = true
        
        self.addSubview(refreshControlIndicator!)
        refreshControlIndicator?.translatesAutoresizingMaskIntoConstraints = false
        
        refreshControlIndicator?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        refreshControlIndicator?.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        
        refreshControlIndicator?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        refreshControlIndicator?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        
    
        

    }
    func startAnimate(){
        refreshControlIndicator?.startAnimating()
    }
    func stopAnimate(){
        refreshControlIndicator?.stopAnimating()
    }
}
