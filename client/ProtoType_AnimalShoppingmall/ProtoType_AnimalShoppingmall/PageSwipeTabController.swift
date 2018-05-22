//
//  PageSwipeTabController.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 20..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class PageSwipeTabController: UIViewController {

    var tabViews : [PageTabItem] = [PageTabItem]()
    
    var tabBarView: PageTabBar?
    var tabViewContainer : UICollectionView?
    let cellId = "cellId"
    var tabBarHeight : CGFloat? {
        didSet {
            tabBarHeightConstraint?.constant = tabBarHeight!
        }
    }
    private var tabBarHeightConstraint : NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        setupTabBar()
        setupViewContainer()
        
        setupController()
        
        tabBarView?.layoutIfNeeded()
        self.view.layoutIfNeeded()

    }
    func setupController(){
        
    }
    func setupViewContainer(){
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        tabViewContainer?.clipsToBounds = true
        
        tabViewContainer = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabViewContainer?.collectionViewLayout = layout
        tabViewContainer?.isPagingEnabled = true
        
        tabViewContainer?.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        
        view.addSubview(tabViewContainer!)
        
        tabViewContainer?.translatesAutoresizingMaskIntoConstraints = false
        tabViewContainer?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tabViewContainer?.topAnchor.constraint(equalTo: (tabBarView?.bottomAnchor)!).isActive = true

        //tabViewContainer?.heightAnchor.constraint(equalToConstant: 498).isActive = true
        tabViewContainer?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tabViewContainer?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        
        tabViewContainer?.dataSource=self
        tabViewContainer?.delegate = self
        tabViewContainer?.showsHorizontalScrollIndicator = false
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tabViewContainer?.layoutIfNeeded()
        //tabViewContainer?.collectionViewLayout.invalidateLayout()
        
    }
    func setupTabBar(){
        tabBarView = {
            let tb = PageTabBar()
            tb.parentController = self
            return tb
        }()
        tabBarView?.translatesAutoresizingMaskIntoConstraints = false
        tabBarView?.clipsToBounds = true
        view.addSubview(tabBarView!)
        tabBarView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        if let navC = navigationController {
//            tabBarView?.topAnchor.constraint(equalTo: navC.navigationBar.bottomAnchor).isActive = true
//        }else{
//            tabBarView?.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
//        }
        
        
        var heightConstant = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        if (self.navigationController != nil) {
            heightConstant += (self.navigationController?.navigationBar.frame.height)!
        }
//        tabBarView?.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        tabBarView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: heightConstant).isActive = true
        
        tabBarView?.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        tabBarHeightConstraint = tabBarView?.heightAnchor.constraint(equalToConstant: 10)
        tabBarHeightConstraint?.isActive = true
        tabBarHeight = UIScreen.main.bounds.height * 0.079
        
        tabBarView?.layoutIfNeeded()
        
        tabBarView?.backgroundColor = UIColor.white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: (tabBarView?.frame.width)!/CGFloat(tabViews.count), height: (tabBarView?.frame.height)!)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        tabBarView?.pageTabBar.collectionViewLayout = layout
        tabBarView?.pageTabBar.collectionViewLayout.invalidateLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func addTabView(_view : UIView){
        
        
        
        
        tabViews.append(PageTabItem(_view: _view))
        
        tabBarView?.pageTabBar.reloadData()
        tabViewContainer?.reloadData()
        tabBarView?.pageIndicatorWidthAnchorConstraint?.constant = (tabBarView?.frame.width)!/CGFloat(tabViews.count)
        self.view.layoutIfNeeded()
        let indexPath = IndexPath(item: 0, section: 0)
        tabBarView?.pageTabBar.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
        
    }
    func addTabView(_item : PageTabItem){
        tabViews.append(_item)
        
        tabBarView?.pageTabBar.reloadData()
        tabViewContainer?.reloadData()
        tabBarView?.pageIndicatorWidthAnchorConstraint?.constant = (tabBarView?.frame.width)!/CGFloat(tabViews.count)
        self.view.layoutIfNeeded()
        let indexPath = IndexPath(item: 0, section: 0)
        tabBarView?.pageTabBar.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }
    
    func setupTabBarIcon(cell : TabCell, index : Int){
        
    }

}

extension PageSwipeTabController : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        tabBarView?.pageIndicatorLeftAnchorConstraint?.constant = scrollView.contentOffset.x / CGFloat(tabViews.count)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        
        let index = targetContentOffset.pointee.x / view.frame.width
        //view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        tabBarView?.pageTabBar.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }
    
    func scrollToMenuIndex(menuIndex : Int){
        
        let indexPath = IndexPath(item: menuIndex, section: 0)
        tabViewContainer?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
}

extension PageSwipeTabController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        
        cell.page = tabViews[indexPath.item].view
        
        setupCell(cell: cell)
        
        return cell
    }
    
    func setupCell(cell : PageCell){
        
    }

}

extension PageSwipeTabController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        
//        print("screen : ", UIScreen.main.bounds.height)
//        print("status : ", UIApplication.shared.statusBarFrame.height)
//        print("tabbar : ", tabBarView?.frame.height)
//        print("container : ", collectionView.frame.height)
//        print("nav : ", self.navigationController?.navigationBar.height)
//        let sum = UIApplication.shared.statusBarFrame.height + (tabBarView?.frame.height)! + collectionView.frame.height + (self.navigationController?.navigationBar.height)!
//        print(sum)
//        
//        var height = collectionView.frame.height - (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
//        if (self.navigationController != nil) {
//            height -= (self.navigationController?.navigationBar.height)!
//        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        //return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

