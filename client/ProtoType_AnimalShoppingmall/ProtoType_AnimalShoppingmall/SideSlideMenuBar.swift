//
//  SideSlideMenuBar.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 23..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class SideSlideMenuBar : NSObject{
    var blackView = UIView()
    var sideMenuView : SideSlideMenuBarView = SideSlideMenuBarView()
    
    var parentViewController : UIViewController?
    var xPosConstraint : NSLayoutConstraint?
    init(viewController : UIViewController) {
        super.init()
        parentViewController = viewController
        sideMenuView.parentObject = self
        
    }
    
    func showSideSlideMenuBar(){

        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideSideSlideMenuBar)))
        
        parentViewController?.view.addSubview(blackView)
        
        parentViewController?.view.addSubview(sideMenuView)
        
        blackView.frame = (parentViewController?.view.frame)!
        blackView.alpha = 0
        
        sideMenuView.translatesAutoresizingMaskIntoConstraints = false
        var topConstant = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        if (parentViewController?.navigationController != nil) {
            topConstant += (parentViewController?.navigationController?.navigationBar.frame.height)!
        }
        
        
        sideMenuView.topAnchor.constraint(equalTo: (parentViewController?.view.topAnchor)!, constant: topConstant).isActive = true
        sideMenuView.bottomAnchor.constraint(equalTo: (parentViewController?.view.bottomAnchor)!).isActive = true
        let isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
        print(UIScreen.main.bounds)
        sideMenuView.widthAnchor.constraint(equalTo: (parentViewController?.view.widthAnchor)!, multiplier: isPad ? 0.5 : 2/3).isActive = true
        xPosConstraint = sideMenuView.leftAnchor.constraint(equalTo: (parentViewController?.view.rightAnchor)!)
        xPosConstraint?.isActive = true
        parentViewController?.view.layoutIfNeeded()
        
        sideMenuView.viewWillAppear()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blackView.alpha = 1
            
            
            self.xPosConstraint?.constant = -self.sideMenuView.frame.width
            
            self.parentViewController?.view.layoutIfNeeded()
            
        }, completion: nil)
        
    }
    
    func hideSideSlideMenuBar(){
        if (self.parentViewController as! ResultVC).isKeyboard{
            self.parentViewController?.view.endEditing(true)
            return
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            self.xPosConstraint?.constant = 0
            self.parentViewController?.view.layoutIfNeeded()
        }, completion: {(res)->() in
            self.blackView.removeFromSuperview()
            self.sideMenuView.removeFromSuperview()
            
        })
    }
    
}
