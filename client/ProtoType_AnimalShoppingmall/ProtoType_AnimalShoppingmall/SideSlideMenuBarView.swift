//
//  SideSlideMenuBar.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 22..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit
class SideSlideMenuBarView : UIView {
    
    var menuTableView : UITableView?
    var data : [SlideMenuDataSet] = SlideMenuDataSet.setSideSlideMenuBarSets()
    let cellId = "cellId"
    var selected = -1
    var topBar = UIToolbar()
    var searchTextField = UITextField()
    var buttonContainer = UIToolbar()
    
    var brandTableView : UITableView?
    var typeTableView : UITableView?
    var typeLabel : UILabel?
    var brandLabel : UILabel?
    
    var initBtn : UIButton?
    var applyBtn : UIButton?
    var typeList = [DataForSideMenu]()
    var brandList = [DataForSideMenu]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var heightTypeTable : NSLayoutConstraint?
    
    var sideBarWidth : CGFloat
    var cellFont : UIFont?
    
    var parentObject : NSObject? {
        didSet{
            initSubViews()
        }
    }
    
    override init(frame: CGRect) {
        
        let isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
        sideBarWidth = isPad ? UIScreen.main.bounds.width*0.5 : UIScreen.main.bounds.width * 2/3
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.lightGray
        
        
        
    }
    func viewWillAppear(){
        self.layoutIfNeeded()
        
        modifyLabelSize()
        modifyHeightTypeTable()
    }
    func modifyLabelSize(){
        typeLabel?.font = UIFont.systemFont(ofSize: findIconLabelSize(height: (typeLabel?.frame.height)!, label: typeLabel!))
        brandLabel?.font = UIFont.systemFont(ofSize: findIconLabelSize(height: (brandLabel?.frame.height)!, label: brandLabel!))
        cellFont = UIFont.systemFont(ofSize: (brandLabel?.font.pointSize)! - 2.5)
        brandTableView?.reloadData()
        typeTableView?.reloadData()
        
        let tmp = UILabel()
        tmp.text = "Test"
        
        applyBtn?.titleLabel?.font = UIFont.systemFont(ofSize: findIconLabelSize(height: (applyBtn?.frame.height)! * 0.4, label: tmp))
        initBtn?.titleLabel?.font = applyBtn?.titleLabel?.font
    }
    func modifyHeightTypeTable(){
        

        
        if (typeTableView?.frame.height)! > (typeTableView?.contentSize.height)!{
            heightTypeTable?.constant = (typeTableView?.contentSize.height)! - (typeTableView?.frame.height)!
            self.layoutIfNeeded()
        }
    }
    func initSubViews(){
        setupTopbar()
        setupSearchTextField()
        
        setupButtonGroup()
        
        //setupTableView()
        
        setupTypeTable()
        setupBrandTable()
        
    }
    func setupBrandTable(){
        
        let labelContainer = UIView()
        
        labelContainer.backgroundColor = UIColor.lightGray
        
        self.addSubview(labelContainer)
        
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        labelContainer.topAnchor.constraint(equalTo: (typeTableView?.bottomAnchor)!).isActive = true
        labelContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelContainer.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        labelContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.057).isActive = true
        labelContainer.backgroundColor = myColor.deselectedSideTabnColor
        brandLabel = UILabel()
        
        brandLabel?.text = "Brand"
        
        labelContainer.addSubview(brandLabel!)
        brandLabel?.textColor = UIColor.white
        brandLabel?.translatesAutoresizingMaskIntoConstraints = false
        brandLabel?.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor).isActive = true
        brandLabel?.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor).isActive = true
        brandLabel?.widthAnchor.constraint(equalTo: labelContainer.widthAnchor, multiplier: 0.9).isActive = true
        brandLabel?.heightAnchor.constraint(equalTo: labelContainer.heightAnchor, multiplier: 0.8).isActive = true

        
        brandTableView = UITableView()
        
        self.addSubview(brandTableView!)
        
        brandTableView?.tag = 1
        brandTableView?.translatesAutoresizingMaskIntoConstraints = false
        
        brandTableView?.topAnchor.constraint(equalTo: labelContainer.bottomAnchor).isActive = true
        brandTableView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        brandTableView?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        brandTableView?.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor).isActive = true
        
        brandTableView?.delegate = self
        brandTableView?.dataSource=self
        
        brandTableView?.register(SideSlideMenuBarTableCell.self, forCellReuseIdentifier: cellId)
        
        brandTableView?.tableFooterView = UIView()
        
        brandTableView?.allowsSelection = false
        makeBrandList()
        
        
    }
    func setupTypeTable(){
        
        let labelContainer = UIView()
        
        labelContainer.backgroundColor = UIColor.lightGray
        
        self.addSubview(labelContainer)
        
        labelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        labelContainer.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 2).isActive = true
        labelContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        labelContainer.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        labelContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.057).isActive = true
        labelContainer.backgroundColor = myColor.deselectedSideTabnColor
        typeLabel = UILabel()
        
        typeLabel?.text = "Food Type"
        labelContainer.addSubview(typeLabel!)
        typeLabel?.textColor = UIColor.white
        typeLabel?.translatesAutoresizingMaskIntoConstraints = false
        typeLabel?.centerXAnchor.constraint(equalTo: labelContainer.centerXAnchor).isActive = true
        typeLabel?.centerYAnchor.constraint(equalTo: labelContainer.centerYAnchor).isActive = true
        typeLabel?.widthAnchor.constraint(equalTo: labelContainer.widthAnchor, multiplier: 0.9).isActive = true
        typeLabel?.heightAnchor.constraint(equalTo: labelContainer.heightAnchor, multiplier: 0.8).isActive = true
        
        self.layoutIfNeeded()
        
        
        typeTableView = UITableView()
        
        self.addSubview(typeTableView!)
        
        typeTableView?.tag = 2
        
        typeTableView?.translatesAutoresizingMaskIntoConstraints = false
        
        typeTableView?.topAnchor.constraint(equalTo: labelContainer.bottomAnchor).isActive = true
        typeTableView?.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        typeTableView?.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        heightTypeTable = typeTableView?.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        heightTypeTable?.isActive = true
        
        typeTableView?.delegate = self
        typeTableView?.dataSource=self
        
        typeTableView?.register(SideSlideMenuBarTableCell.self, forCellReuseIdentifier: cellId)
        
        typeTableView?.tableFooterView = UIView()
        
        typeTableView?.allowsSelection = false
        makeTypeList()
        
    }
    func setupTableView(){
        menuTableView = UITableView()
        
        self.addSubview(menuTableView!)
        
        menuTableView?.translatesAutoresizingMaskIntoConstraints = false
        menuTableView?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        menuTableView?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        menuTableView?.bottomAnchor.constraint(equalTo: buttonContainer.topAnchor, constant: 2).isActive = true
        menuTableView?.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 2).isActive = true
        
        menuTableView?.register(SideSlideMenuBarTableCell.self, forCellReuseIdentifier: cellId)
        
        menuTableView?.delegate = self
        menuTableView?.dataSource = self
        
        menuTableView?.tableFooterView = UIView()
    }
    func setupTopbar(){
        topBar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topBar)
        
        topBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        topBar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        topBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07).isActive = true
        
        topBar.barTintColor = myColor.mainColor
        
        let closeButton = UIButton()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(closeButton)
        
        
        
        closeButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        closeButton.heightAnchor.constraint(equalTo: topBar.heightAnchor, multiplier: 0.8).isActive = true
        closeButton.widthAnchor.constraint(equalTo: topBar.heightAnchor, multiplier: 0.8).isActive = true
        
        closeButton.rightAnchor.constraint(equalTo: topBar.rightAnchor,constant: -sideBarWidth * 0.05).isActive = true
        
        closeButton.addTarget(self, action: #selector(self.closeSideSlideMenuBar(sender:)), for: .touchUpInside)
      
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        
    }
    func setupSearchTextField(){
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchTextField)
        
        searchTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.98).isActive = true
        searchTextField.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 2).isActive = true
        searchTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.071).isActive = true
        
        searchTextField.placeholder = "Search"
        searchTextField.backgroundColor = UIColor.white
        searchTextField.borderStyle = UITextBorderStyle.roundedRect
        
    }
    func setupButtonGroup(){
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonContainer)
        
        buttonContainer.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        buttonContainer.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        buttonContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonContainer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/10).isActive = true
        
        buttonContainer.backgroundColor = UIColor.gray
        

        initBtn = UIButton()
        initBtn?.setTitle("Reset", for: .normal)
        initBtn?.setTitleColor(UIColor.white, for: .normal)
        initBtn?.backgroundColor = myColor.deselectedSideTabnColor

        buttonContainer.addSubview(initBtn!)
        initBtn?.translatesAutoresizingMaskIntoConstraints = false
        initBtn?.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor).isActive = true
        initBtn?.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor, multiplier: 0.5).isActive = true
        initBtn?.topAnchor.constraint(equalTo: buttonContainer.topAnchor).isActive = true
        initBtn?.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor).isActive = true
        initBtn?.addTarget(self, action: #selector(self.clickInitBtn(_:)), for: .touchUpInside)
        
        applyBtn = UIButton()
        
        applyBtn?.setTitle("Apply", for: .normal)
        applyBtn?.backgroundColor = myColor.mainColor
        applyBtn?.setTitleColor(UIColor.white, for: .normal)

        buttonContainer.addSubview(applyBtn!)
        
        applyBtn?.translatesAutoresizingMaskIntoConstraints = false
        applyBtn?.rightAnchor.constraint(equalTo: buttonContainer.rightAnchor).isActive = true
        applyBtn?.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor, multiplier: 0.5).isActive = true
        applyBtn?.topAnchor.constraint(equalTo: buttonContainer.topAnchor).isActive = true
        applyBtn?.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor).isActive = true
        applyBtn?.addTarget(self, action: #selector(self.clickApplyBtn(_:)), for: .touchUpInside)

    }
    
    func makeTypeList(){
        if appDelegate.after_item_list_filter.pet_type == 0 {
            if appDelegate.after_item_list_filter.item_type == 0 {
                typeList.append(DataForSideMenu(_content: "dry food", _tag: 2))
                typeList.append(DataForSideMenu(_content: "raw food", _tag: 2))
                typeList.append(DataForSideMenu(_content: "canned food", _tag: 2))
            }else{
                typeList.append(DataForSideMenu(_content: "biscuits & bakery", _tag: 2))
                typeList.append(DataForSideMenu(_content: "bones & rawhide", _tag: 2))
                typeList.append(DataForSideMenu(_content: "chewy treats", _tag: 2))
                typeList.append(DataForSideMenu(_content: "dental treats", _tag: 2))
                typeList.append(DataForSideMenu(_content: "jerky", _tag: 2))
                typeList.append(DataForSideMenu(_content: "training treats", _tag: 2))
            }
        }else{
            if appDelegate.after_item_list_filter.item_type == 0 {
                typeList.append(DataForSideMenu(_content: "dry food", _tag: 2))
                typeList.append(DataForSideMenu(_content: "raw food", _tag: 2))
                typeList.append(DataForSideMenu(_content: "canned food", _tag: 2))
            }else{
                typeList.append(DataForSideMenu(_content: "crunchy treats", _tag: 2))
                typeList.append(DataForSideMenu(_content: "catnip & grass", _tag: 2))
                typeList.append(DataForSideMenu(_content: "dental treats", _tag: 2))
                typeList.append(DataForSideMenu(_content: "jerky", _tag: 2))
                typeList.append(DataForSideMenu(_content: "soft treats", _tag: 2))
            }
        }
    }
    
    func makeBrandList(){
        for content in appDelegate.brand_list {
            brandList.append(DataForSideMenu(_content: content, _tag: 1))
        }
    }
    
    func clickInitBtn(_ sender : UIButton){
        
        for d in data{
            
            for content in d.contents!{
                content.selected = false
            }
        }
        
        for data in brandList {
            data.selected = false
        }
        for data in typeList {
            data.selected = false
        }
        
        brandTableView?.reloadData()
        typeTableView?.reloadData()
        
        menuTableView?.reloadData()
        
        let parentObject = self.parentObject as! SideSlideMenuBar
        
        let parentViewController = parentObject.parentViewController as! ResultVC
        
        parentViewController.initFilter()
        
    }
    func clickApplyBtn(_ sender : UIButton){
        let parentObject = self.parentObject as! SideSlideMenuBar
        
        let parentViewController = parentObject.parentViewController as! ResultVC
        
        let search = searchTextField.text!
        var brands = [String]()
        for brand in brandList{
            if brand.selected {
                brands.append(brand.content)
            }
        }
        var types = [String]()
        for type in typeList{
            if type.selected {
                types.append(type.content)
            }
        }
        
        parentViewController.filteredResult(_search: search, brands: brands, types: types)
    }
    func closeSideSlideMenuBar(sender : UIButton){
        let parent = parentObject as! SideSlideMenuBar
        parent.hideSideSlideMenuBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func tappedSection(gestureRecognizer: SectionTapGestureRecognizer) {
        
        if(selected == gestureRecognizer.index){
            selected = -1
        }else{
            selected = gestureRecognizer.index!
        }
        
        menuTableView?.reloadData()
    }
    class SectionTapGestureRecognizer : UITapGestureRecognizer{
        var index : Int?
    }
    func clickSwitch(_ sender: MySwitch){
        if sender.isOn {
            if sender.tag == 1 {
                brandList[sender.index!].selected = true
            }else if sender.tag == 2 {
                typeList[sender.index!].selected = true
            }else {
                data[sender.section!].contents?[sender.index!].selected = true
            }
            
        }else{
            
            if sender.tag == 1 {
                brandList[sender.index!].selected = false
            }else if sender.tag == 2 {
                typeList[sender.index!].selected = false
            }else {
                data[sender.section!].contents?[sender.index!].selected = false
            }
        }
    }
    
}
extension SideSlideMenuBarView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
//        if tableView.tag == 2 || tableView.tag == 1 {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return self.frame.height * 0.057
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        if tableView.tag == 2 {
            return nil
        }else if tableView.tag == 1 {
            return nil
        }else{
            let sectionView = SideSlideMenuTableSection()
            sectionView.backgroundColor = UIColor.gray
            sectionView.label?.text  = data[section].section
            
            if section == selected {
                sectionView.arrowLabel?.image = UIImage(named: "CollapseArrow")
            }else{
                sectionView.arrowLabel?.image = UIImage(named: "ExpandArrow")
            }
            
            let tapGesture = SectionTapGestureRecognizer(target: self, action: #selector(self.tappedSection(gestureRecognizer:)))
            tapGesture.index = section
            
            tapGesture.numberOfTouchesRequired = 1
            tapGesture.numberOfTapsRequired = 1
            sectionView.addGestureRecognizer(tapGesture)
            
            return sectionView
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        
        if tableView.tag == 2 {
            return 0
        }else if tableView.tag == 1 {
            return 0
        }
        else{
            return (menuTableView?.frame.height)!/CGFloat(data.count)
        }
        
    }
    
}
extension SideSlideMenuBarView : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView.tag == 2 {
            return typeList.count
        }
        else if tableView.tag == 1 {
            return brandList.count
        }
        else {
            if section == selected{
                return data[section].contents!.count
            }else {
                return 0
            }
        }
        
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        if tableView.tag == 2 {
            return 1
        }else if tableView.tag == 1 {
            return 1
        }
        else{
            return data.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SideSlideMenuBarTableCell
        if tableView.tag == 2 {
            
            cell.label?.text = typeList[indexPath.row].content
            cell.checkSelected?.isOn = typeList[indexPath.row].selected
            
            cell.checkSelected?.index = indexPath.item
            cell.checkSelected?.tag = 2
            cell.checkSelected?.addTarget(self, action: #selector(self.clickSwitch(_:)), for: .valueChanged)
            cell.setUI()
            self.layoutIfNeeded()
            
            if cellFont != nil {
                cell.label?.font = cellFont
            }
            
            

            
        }
        else if tableView.tag == 1 {
            cell.label?.text = brandList[indexPath.row].content
            cell.checkSelected?.isOn = brandList[indexPath.row].selected
            
            cell.checkSelected?.index = indexPath.item
            cell.checkSelected?.tag = 1
            cell.checkSelected?.addTarget(self, action: #selector(self.clickSwitch(_:)), for: .valueChanged)
            cell.setUI()
            self.layoutIfNeeded()

            if cellFont != nil {
                cell.label?.font = cellFont
            }
        }
        else{
            
            cell.label?.text = data[indexPath.section].contents?[indexPath.item].content
            cell.checkSelected?.isOn = (data[indexPath.section].contents?[indexPath.item].selected)!
            
            cell.checkSelected?.index = indexPath.item
            cell.checkSelected?.section = indexPath.section
            cell.checkSelected?.addTarget(self, action: #selector(self.clickSwitch(_:)), for: .valueChanged)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if tableView.tag == 2 {
            return ""
        }else if tableView.tag == 1 {
            return ""
        }
        else {
            return data[section].section
        }
        
    }
    
}
class SideSlideMenuTableSection : UIView{
    
    var arrowLabel : UIImageView?
    var label : UILabel?
    var line : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        
        
        self.addSubview(label!)
        label?.translatesAutoresizingMaskIntoConstraints = false

        label?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        label?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        label?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label?.textColor = UIColor.white
        
        arrowLabel = UIImageView()
        self.addSubview(arrowLabel!)
        arrowLabel?.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        arrowLabel?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrowLabel?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        arrowLabel?.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4*1.3).isActive = true
        
        line = UIView()
        line?.backgroundColor = UIColor.black
        self.addSubview(line!)
        line?.translatesAutoresizingMaskIntoConstraints = false
        line?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        line?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        line?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        line?.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class SideSlideMenuBarTableCell : UITableViewCell {
    var label : UILabel?
    var checkSelected : MySwitch?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label = UILabel()
        self.layoutIfNeeded()
        
        checkSelected = MySwitch(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        addSubview(checkSelected!)
//        checkSelected?.layoutIfNeeded()
        //checkSelected?.backgroundColor = UIColor.blue
        //checkSelected?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        
        label?.translatesAutoresizingMaskIntoConstraints = false
        //checkSelected?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label!)
        
        
        
        
//        checkSelected?.contentMode = .scaleAspectFit
//        checkSelected?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.frame.width*0.08).isActive = true
//        checkSelected?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        checkSelected?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55).isActive = true
//        checkSelected?.widthAnchor.constraint(equalTo: (checkSelected?.heightAnchor)!, multiplier: 2.3).isActive  = true
        checkSelected?.center = self.center

        
    }
    func setUI(){
        label?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width*0.06).isActive = true
        label?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        label?.widthAnchor.constraint(equalTo:  self.widthAnchor, multiplier: 0.7).isActive  = true
        
        let width = self.frame.width*0.23
        checkSelected?.center = CGPoint(x: self.frame.width*0.745 + width/2, y: self.frame.height/2)
        checkSelected?.transform = CGAffineTransform(scaleX: (self.frame.height * 0.6)/31, y: (self.frame.height * 0.6)/31)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class MySwitch : UISwitch{
    var section : Int?
    var index : Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
