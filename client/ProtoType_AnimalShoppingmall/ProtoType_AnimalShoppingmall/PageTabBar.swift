//
//  PageTabBar.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 20..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class PageTabBar: UIView {
    
    var pageTabBar : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let tb = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return tb
    }()
    
    var parentController: PageSwipeTabController?
    var pageIndicator : UIView?
    
    let cellId = "cellId"
    //var pageViews = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        pageTabBar.dataSource = self
        pageTabBar.delegate = self
        addSubview(pageTabBar)
        
        pageTabBar.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: [], metrics: nil, views: ["v0":pageTabBar]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: [], metrics: nil, views: ["v0":pageTabBar]))
        
        pageTabBar.register(TabCell.self, forCellWithReuseIdentifier: cellId)
        
        setupIndicatorBar()
        
    }
    
    var pageIndicatorLeftAnchorConstraint: NSLayoutConstraint?
    var pageIndicatorWidthAnchorConstraint: NSLayoutConstraint?
    var pageIndicatorHeightAnchorConstraint: NSLayoutConstraint?
    
    func setupIndicatorBar() {
        pageIndicator = UIView()
        pageIndicator?.backgroundColor = myColor.mainColor
        pageIndicator?.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pageIndicator!)
        
        pageIndicatorLeftAnchorConstraint = pageIndicator?.leftAnchor.constraint(equalTo: self.leftAnchor)
        pageIndicatorLeftAnchorConstraint?.isActive = true
        
        pageIndicator?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        pageIndicatorWidthAnchorConstraint = pageIndicator?.widthAnchor.constraint(equalToConstant: self.frame.width)
        pageIndicatorWidthAnchorConstraint?.isActive = true
        pageIndicatorHeightAnchorConstraint = pageIndicator?.heightAnchor.constraint(equalToConstant: 2)
        pageIndicatorHeightAnchorConstraint?.isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTabBar : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (parentController?.tabViews.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TabCell
        //cell.backgroundColor = UIColor.black
        cell.backgroundColor = UIColor.white
        parentController?.setupTabBarIcon(cell : cell, index : indexPath.item)
        cell.layer.addBorder(edge: .right, color: UIColor.lightGray, thickness: 0.5)
        cell.tabLabel?.text = parentController?.tabViews[indexPath.item].title
        
        
        return cell
    }
}

extension PageTabBar : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parentController?.scrollToMenuIndex(menuIndex: indexPath.item)

    }
}

extension PageTabBar : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: frame.width / CGFloat((parentController?.tabViews.count)!), height: frame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}

class TabCell: BaseCell {
    
//    let imageView : UIImageView? = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
//        iv.tintColor = UIColor.darkGray
//        return iv
//    }()
    var tabLabel : UILabel?
    var selectedColor : UIColor = myColor.mainColor
    var defaultColor : UIColor = myColor.deselectedMainColor
    

    
    override var isHighlighted: Bool {
        didSet {
            tabLabel?.textColor = isHighlighted ? selectedColor : defaultColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            tabLabel?.textColor = isSelected ? selectedColor : defaultColor
        }
    }
    
//    func setIconSize(_width : Int, _height : Int){
//        
//        let width = "H:[v0(\(_width))]"
//        let height = "V:[v0(\(_height))]"
//        
//
//        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: width, options: [], metrics: nil, views: ["v0": imageView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: height, options: [], metrics: nil, views: ["v0": imageView]))
//        
//    }
    
    override func setupViews() {

//        addSubview(imageView!)
//        imageView?.translatesAutoresizingMaskIntoConstraints = false
//        setIconSize(_width: 25, _height: 25)
//        
//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        tabLabel = UILabel()
        addSubview(tabLabel!)
        
        tabLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        tabLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tabLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        tabLabel?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        tabLabel?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        self.layoutIfNeeded()
        tabLabel?.font = UIFont.systemFont(ofSize: findIconLabelSize(height: (tabLabel?.frame.height)!, label: tabLabel!) )
        
        tabLabel?.textAlignment = .center
        tabLabel?.textColor = defaultColor
    }
    

}
