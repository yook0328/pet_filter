//
//  SubViewMenuButton04.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 21..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit


class SubViewMenuButton04: UIView{
    
    
    var sideTabContainer: UICollectionView?
    var contentsListContainer: UITableView?
    var category : [DataSet]?
    var selected : Int = 0
    let sideTabCellId = "sideTabCell"
    let tableCellId = "tableCellId"
    let headerId = "headerId"
    
    var delegate : FilteredTableDelegate?
    var mark : UIImage?
    override init(frame: CGRect) {
        super.init(frame: frame)
        category = DataSet.setDataSets()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: sideTabContainer.frame.width, height: sideTabContainer.frame.width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        print("check point \(self.tag)")
        self.layer.addBorder(edge: .top, color: UIColor.lightGray, thickness: 0.5)
        
        
        sideTabContainer = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(sideTabContainer!)
        
        sideTabContainer?.translatesAutoresizingMaskIntoConstraints = false
        sideTabContainer?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sideTabContainer?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sideTabContainer?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        sideTabContainer?.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/6).isActive = true
        
        //sideTabContainer!.collectionViewLayout = layout
        sideTabContainer?.backgroundColor = myColor.deselectedSideTabnColor
        sideTabContainer?.delegate = self
        sideTabContainer?.dataSource = self
        sideTabContainer?.register(SideTabButtonCell.self, forCellWithReuseIdentifier: sideTabCellId)
        
        
        
        contentsListContainer = UITableView(frame: .zero)
        addSubview(contentsListContainer!)
        contentsListContainer?.translatesAutoresizingMaskIntoConstraints = false
        contentsListContainer?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentsListContainer?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentsListContainer?.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        contentsListContainer?.leftAnchor.constraint(equalTo: (sideTabContainer?.rightAnchor)!).isActive = true
        contentsListContainer?.register(FilterTableCell.self, forCellReuseIdentifier: tableCellId)
        contentsListContainer?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerId)
        contentsListContainer?.delegate = self
        contentsListContainer?.dataSource = self
        contentsListContainer?.allowsMultipleSelection = true
        
        //collectionView 안에 쓸데 없이 있는 위에 여백 제거.
        
        //self.automaticallyAdjustsScrollViewInsets = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        
//        category = DataSet.setDataSets()
//        
//        let width = UIScreen.main.bounds.width
//        let height = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height
//        
//        sideTabContainer.frame = CGRect(x: 0, y: 0, width: width*0.2, height: height)
//        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: sideTabContainer.frame.width, height: sideTabContainer.frame.width)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        sideTabContainer!.collectionViewLayout = layout
//        sideTabContainer.backgroundColor = UIColor.gray
//        
//        contentsListContainer.frame = CGRect(x: width*0.2 , y: 0, width: width*0.8, height: height)
//        
//        
//        //collectionView 안에 쓸데 없이 있는 위에 여백 제거.
//        self.automaticallyAdjustsScrollViewInsets = false
//        
//    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewWillAppear(_ animated: Bool){
//        super.viewWillAppear(animated)
//        let path = NSIndexPath(row: 0, section: 0)
//        
//        sideTabContainer.selectItem(at: path as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.top) // 셀 선택 소스
//        
//        
//    }
    
    
}

extension SubViewMenuButton04 : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //self.performSegue(withIdentifier: "MenuButton01Nav", sender: nil)
        //        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MenuButton04")
        //        self.navigationController?.pushViewController(nextViewController, animated: true)
        selected = indexPath.row
        contentsListContainer?.reloadData()
        contentsListContainer?.layoutIfNeeded()
        
        contentsListContainer?.setContentOffset(CGPoint(x: 0, y: (contentsListContainer?.contentInset.top)!), animated: false)
    }
}

extension SubViewMenuButton04 : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ((category?.count)!+1)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sideTabCellId, for: indexPath as IndexPath) as! SideTabButtonCell
        
        if indexPath.row == 0 {
            cell.setText(_text: "ALL")
        }else {
            cell.setText(_text: (category?[indexPath.row-1].section)!)
        }
        
        cell.iconLabel?.numberOfLines = 2
        cell.layer.addBorder(edge: .bottom, color: UIColor.darkGray, thickness: 1)
        cell.layer.addBorder(edge: .right, color: UIColor.darkGray, thickness: 1)
        cell.selectedBackgroundView = UIView(frame: cell.bounds)
        cell.selectedBackgroundView!.backgroundColor = myColor.mainColor
        
       
        return cell
    }
}
extension SubViewMenuButton04 : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{

        return CGSize(width: sideTabContainer!.frame.width, height: sideTabContainer!.frame.height/6)
    }
}
extension SubViewMenuButton04 : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = myColor.sectionColor

    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
//        tableView.layoutIfNeeded()
//        
//        //let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
//        print("content test : \(tableView.contentSize)")
//        let frame = tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.frame
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: (frame?.width)!, height: UIScreen.main.bounds.height * 0.05))
//        header.backgroundColor = myColor.sectionColor
////        header.layer.addBorder(edge: .bottom, color: UIColor.gray, thickness: 0.5)
////        //header.layer.addBorder(edge: .top, color: UIColor.gray, thickness: 0.5)
////        header.layer.addBorder(edge: .right, color: UIColor.gray, thickness: 0.5)
//        let label = UILabel()
//        label.text =  selected == 0 ? category?[section].section : category?[selected-1].section
//        label.text = "test test "
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        header.addSubview(label)
//        print("contentsListContainer : \(contentsListContainer?.frame)")
//        print("table : \(tableView.frame)")
//        print("table content : \(tableView.contentSize)")
//        
//        header.layoutIfNeeded()
//        
//
//        print("header : \(header.frame)")
//        label.centerYAnchor.constraint(equalTo: (header.centerYAnchor)).isActive = true
//        label.heightAnchor.constraint(equalTo: (header.heightAnchor), multiplier: 0.8).isActive = true
//        
//        label.leftAnchor.constraint(equalTo: (header.leftAnchor)).isActive = true
//        label.widthAnchor.constraint(equalTo: (header.widthAnchor), multiplier: 0.8).isActive = true
//        
//        label.layoutIfNeeded()
//        
//        print("label frame : \(label.frame)")
//        label.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: label.frame.height, label: label))
//        
//        return header
//        
//        
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return UIScreen.main.bounds.height * 0.05
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return UIScreen.main.bounds.height * 0.075
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if selected == 0 {
//            var select : Bool = (category?[indexPath.section].contents?[indexPath.item].selected)!
//            if select {
//                category?[indexPath.section].contents?[indexPath.item].selected = false
//            }else{
//                category?[indexPath.section].contents?[indexPath.item].selected = true
//            }
            category?[indexPath.section].contents?[indexPath.item].selected = true
            category?[indexPath.section].contents?[indexPath.item].reverseSelected = false
            
            delegate?.selected(tag: self.tag, section: indexPath.section, content: indexPath.item)
            
        }else{
//            var select : Bool = (category?[selected].contents?[indexPath.item].selected)!
//            if select {
//                category?[selected].contents?[indexPath.item].selected = false
//            }else{
//                category?[selected].contents?[indexPath.item].selected = true
//            }
            category?[selected-1].contents?[indexPath.item].selected = true
            category?[selected-1].contents?[indexPath.item].reverseSelected = false
            delegate?.selected(tag: self.tag, section: selected-1, content:indexPath.item)
        }
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        if selected == 0 {
            category?[indexPath.section].contents?[indexPath.item].selected = false
            delegate?.deselected(tag: self.tag, section: indexPath.section, content: indexPath.item)
        }else {
            category?[selected-1].contents?[indexPath.item].selected = false
            delegate?.deselected(tag: self.tag, section: selected-1, content:indexPath.item)
        }
        tableView.reloadData()
  
    }
}
extension SubViewMenuButton04 : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if selected == 0 {
            return (category?[section].contents!.count)!
        }else {
            return (category?[selected-1].contents!.count)!
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if selected == 0 {
            return (category?.count)!
        }else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        
        if selected == 0 {
            return category?[section].section
        }else {
            return category?[selected-1].section
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! FilterTableCell
        
        if selected == 0 {
            let data = category?[indexPath.section].contents?[indexPath.row]
            cell.label.text = data?.content
            let isSelect : Bool = (data?.selected)!
            if isSelect {
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
            cell.mark.image = self.mark
            
            if (data?.reverseSelected)! {
                cell.mark.isHidden = false
                
            }else{
                cell.mark.isHidden = true
            }
            
            
        }else {

            let data = category?[selected-1].contents?[indexPath.row]
            cell.label.text = data?.content
            if (data?.selected)!{
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            }
            
            cell.mark.image = self.mark
            
            if (data?.reverseSelected)! {
                cell.mark.isHidden = false
                
            }else{
                cell.mark.isHidden = true
            }
            
        }
        
        //cell.textLabel?.text = (data[selected].getTabItems())[indexPath.row].getItem()
        return cell
        
    }
}

class SideTabButtonCell : UICollectionViewCell{
    var iconLabel: UILabel?
    var heightConstraint : NSLayoutConstraint?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup(){
        iconLabel = UILabel()
        addSubview(iconLabel!)
        
        iconLabel?.translatesAutoresizingMaskIntoConstraints = false
        iconLabel?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        iconLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        iconLabel?.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.9).isActive = true
        heightConstraint = iconLabel?.heightAnchor.constraint(equalToConstant: self.frame.height*0.2)
        heightConstraint?.isActive = true

    }
    
    func setText(_text : String){
        
        

        
        iconLabel?.text = _text
        iconLabel?.textColor = UIColor.white
        iconLabel?.textAlignment = .center
        iconLabel?.layoutIfNeeded()

        iconLabel?.font = UIFont.systemFont(ofSize: findIconLabelSize(height: (iconLabel?.frame.height)!, label: iconLabel!))
        
        if widthOfText(font: (iconLabel?.font)!, text: _text) > (iconLabel?.frame.width)! {
            heightConstraint?.constant = (heightConstraint?.constant)!*2
        }
    }
}
class FilterTableCell : UITableViewCell
{
    var label : UILabel!
    var mark : UIImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupCell()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupCell(){
        
        label = UILabel()
        mark = UIImageView()
        
        label?.translatesAutoresizingMaskIntoConstraints = false
        mark?.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label!)
        self.addSubview(mark!)
        
        let margin : CGFloat = self.frame.width * 0.06

        
        label?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        label?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        label?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        mark?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
        mark?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mark?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        mark?.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        mark?.contentMode = .scaleAspectFit
        self.layoutIfNeeded()
        let scaleFactor :CGFloat = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? 0.8 : 0.6
        label?.font = UIFont.systemFont(ofSize: findIconLabelSize(height: (label?.frame.height)! * scaleFactor, label: label!))
        
        
    }
    
}
