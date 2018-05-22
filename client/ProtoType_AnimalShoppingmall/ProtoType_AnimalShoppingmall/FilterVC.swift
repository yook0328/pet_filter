//
//  FilterVC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 5. 19..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD

class FilterVC: UIViewController {
    
    var sideTabContainer: UICollectionView?
    var contentsListContainer: UITableView?
    var category : [DataSet]?
    var allList : [AllFilter]?
    var selected : Int = 0
    let sideTabCellId = "sideTabCell"
    let tableCellId = "tableCellId"
    let headerId = "headerId"
    var mark : UIImage?
    var topBar: UIView?
    var lineSetting = false
    var sectionWidth : CGFloat = 0
    var rowSize : CGFloat = 0
    var tableFont : UIFont?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        category = DataSet.setDataSets()
        rowSize = UIScreen.main.bounds.height * 0.075
        
        
    
        
        //sideTabContainer!.collectionViewLayout = layout
        setupAllList()
        setupTopBar()
        setupSideTap()
        setupHomeButon()
        setupTableView()
        setupSearchButton()
        setupTableCellFont()
        
        let path = NSIndexPath(row: 0, section: 0)
        sideTabContainer?.selectItem(at: path as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        resetItems()
        
        contentsListContainer?.reloadData()
    }
    func resetItems(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.dog_food_item_list.removeAll()
        appDelegate.brand_list.removeAll()
        appDelegate.itemCount = 0
        appDelegate.before_item_list_filter.resetFiltered()
        appDelegate.filteredCategory.filteredItemList.removeAll()
        appDelegate.filteredCategory.brands.removeAll()
        appDelegate.filteredCategory.count = 0
        
        appDelegate.filteredCategory.search = ""
        appDelegate.filteredCategory.types.removeAll()
    }
    
    func setupAllList(){
        var list = [AllFilter]()
        var section_index = 0
        var content_index = 0
        var sum = 0
        for section in category!{
            content_index = 0
            sum = sum + (section.contents?.count)!
            for contents in section.contents!{
                list.append(AllFilter(_content: contents.content, _section: section_index, _index: content_index))
                
                content_index = content_index + 1
            }
            
            section_index = section_index + 1
        }
        allList = list.sorted { (data00, data01) -> Bool in
            return data00.content < data01.content
        }
        
    }
    func setupTableCellFont(){
        
        self.view.layoutIfNeeded()
        
        let width = 0.9 * ((contentsListContainer?.frame.width)! - sectionWidth * 2)
        let label = UILabel()
        let height = rowSize * 0.6
        label.text = "Specified vegetables"
        label.font = UIFont.systemFont(ofSize: findIconLabelSize(height: height, label: label))
        label.sizeToFit()
        
        while widthOfText(font: label.font, text: label.text!) > width {
            let point = label.font.pointSize
            label.font = UIFont.systemFont(ofSize: point - 0.5)
        }
        
        tableFont = label.font

        
    }
    
    func setupSideTap(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //        layout.itemSize = CGSize(width: sideTabContainer.frame.width, height: sideTabContainer.frame.width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        //self.layer.addBorder(edge: .top, color: UIColor.lightGray, thickness: 0.5)
        
        
        sideTabContainer = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.view.addSubview(sideTabContainer!)
        
        sideTabContainer?.translatesAutoresizingMaskIntoConstraints = false
        sideTabContainer?.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        sideTabContainer?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        sideTabContainer?.topAnchor.constraint(equalTo: (topBar?.bottomAnchor)!).isActive = true
        sideTabContainer?.widthAnchor.constraint(equalTo: (sideTabContainer?.heightAnchor)!, multiplier: 1/6).isActive = true
        sideTabContainer?.backgroundColor = myColor.deselectedSideTabnColor
        sideTabContainer?.delegate = self
        sideTabContainer?.dataSource = self
        sideTabContainer?.register(SideTabCell.self, forCellWithReuseIdentifier: sideTabCellId)
    }
    
    func setupTableView(){
        contentsListContainer = UITableView(frame: .zero)
        self.view.addSubview(contentsListContainer!)
        contentsListContainer?.translatesAutoresizingMaskIntoConstraints = false
        contentsListContainer?.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        contentsListContainer?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contentsListContainer?.topAnchor.constraint(equalTo: (topBar?.bottomAnchor)!).isActive = true
        contentsListContainer?.leftAnchor.constraint(equalTo: (sideTabContainer?.rightAnchor)!).isActive = true
        contentsListContainer?.register(FilterCell.self, forCellReuseIdentifier: tableCellId)
        contentsListContainer?.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerId)
        contentsListContainer?.delegate = self
        contentsListContainer?.dataSource = self
        contentsListContainer?.allowsMultipleSelection = true
    }
    
    func setupTopBar(){
        topBar = UIView()
        
        self.view.addSubview(topBar!)
        
        topBar?.translatesAutoresizingMaskIntoConstraints = false
        
        var topConstant = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        if (self.navigationController != nil) {
            topConstant += (self.navigationController?.navigationBar.frame.height)!
        }
        
        topBar?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        topBar?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        topBar?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topConstant).isActive = true
        topBar?.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.078).isActive = true
        
        self.view.layoutIfNeeded()
        
        let labelForSize = UILabel()
        labelForSize.text = "exclude"
        let font = UIFont.systemFont(ofSize: findIconLabelSize(height: (topBar?.frame.height)! * 0.4, label: labelForSize))
        labelForSize.font = font
        labelForSize.sizeToFit()

        
        sectionWidth = labelForSize.frame.width
        let underLine = CALayer()
        let thickness : CGFloat = 0.5
        
        let ex_label = UILabel()
        ex_label.text = "Exclude"
        ex_label.textAlignment = .center
        //ex_label.font = font
        ex_label.textColor = myColor.excludeLabelColor
        let label_width = sectionWidth * 0.8
        var label_x = (topBar?.frame.width)! - sectionWidth + 0.5 * (sectionWidth - label_width)
        
        ex_label.frame = CGRect(x: label_x, y: 0, width: label_width, height: (topBar?.frame.height)!)
        ex_label.adjustsFontSizeToFitWidth = true
        
        let in_label = UILabel()
        in_label.text = "Include"
        in_label.textAlignment = .center
        //ex_label.font = font
        in_label.textColor = myColor.mainGageColor
        label_x = (topBar?.frame.width)! - sectionWidth * 2 + 0.5 * (sectionWidth - label_width)
        
        in_label.frame = CGRect(x: label_x, y: 0, width: label_width, height: (topBar?.frame.height)!)
        in_label.adjustsFontSizeToFitWidth = true
        
        topBar?.addSubview(in_label)
        topBar?.addSubview(ex_label)
        
        
        underLine.frame = CGRect(x: 0.0, y: (topBar?.frame.height)! - thickness, width: (topBar?.frame.width)!, height: thickness)
        underLine.backgroundColor = UIColor.gray.cgColor
        
        topBar?.layer.addSublayer(underLine)
        

        
        let line01 = CALayer()
        line01.frame = CGRect(x: (topBar?.frame.width)! - sectionWidth - 0.5 * thickness, y: 0, width: thickness, height: (topBar?.frame.height)!)
        line01.backgroundColor = UIColor.gray.cgColor
        
        let line02 = CALayer()
        line02.frame = CGRect(x: (topBar?.frame.width)! - sectionWidth * 2 - 0.5 * thickness, y: 0, width: thickness, height: (topBar?.frame.height)!)
        line02.backgroundColor = UIColor.gray.cgColor
        
        topBar?.layer.addSublayer(line01)
        topBar?.layer.addSublayer(line02)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupHomeButon(){
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(clickedHome(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = myColor.mainColor
        self.navigationController?.navigationBar.tintColor = myColor.mainColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }

    func clickedHome(sender : UIBarButtonItem){
        
        let nextViewController = self.navigationController?.viewControllers[0] as! ViewController
        self.navigationController?.popToViewController(nextViewController, animated: true)
    }
    func setupSearchButton(){
        let button = UIButton(type: .custom)
        
        //button.backgroundColor = UIColor.darkGray
        
        
        //button.clipsToBounds = true
        button.setImage( UIImage(named: "search_back_btn"), for: .normal)
        button.contentMode = .scaleAspectFill
        
        //        button.setTitleColor(UIColor.white, for: .normal)
        //        button.setTitle("Search", for: .normal)
        //button.backgroundColor = myColor.mainColor
        let label = UILabel()
        label.text = "Search"
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        button.addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: button.widthAnchor,multiplier: 0.7).isActive = true
        label.heightAnchor.constraint(equalTo: button.heightAnchor, multiplier: 0.22).isActive = true

        
        let buttonSize = self.view.frame.width/4
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -buttonSize*0.2).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -buttonSize*0.2).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true

        label.layoutIfNeeded()
        label.font = UIFont.systemFont(ofSize: findIconLabelSize(height: label.frame.height, label: label))
        button.addTarget(self, action: #selector(onSearchAction), for: .touchUpInside)
    }
    func onSearchAction(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        for section in category!
        {
            for content in section.contents!
            {
                if content.include{
                    if appDelegate.before_item_list_filter.include.characters.count > 0 {
                        appDelegate.before_item_list_filter.include += "," + content.content
                    }else{
                        appDelegate.before_item_list_filter.include = content.content
                    }
                }
                if content.exclude {
                    if appDelegate.before_item_list_filter.exclude.characters.count > 0 {
                        appDelegate.before_item_list_filter.exclude += "," + content.content
                    }else{
                        appDelegate.before_item_list_filter.exclude = content.content
                    }
                }

            }
        }

        
        
        HUD.show(.progress)
        
        let headers: HTTPHeaders = [
            //            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            //            "Accept": "application/json"
            "Content-Type" : "application/json"
        ]
        
        var url_target = ""
        switch appDelegate.before_item_list_filter.pet_type {
        case 0 :
            if(appDelegate.before_item_list_filter.item_type == 0 ){
                url_target = "/DogFood/findFoodItems"
            }else{
                url_target = "/DogTreats/findFoodItems"
            }
            
            
            break
        case 1 :
            if(appDelegate.before_item_list_filter.item_type == 0 ){
                url_target = "/CatFood/findFoodItems"
            }else{
                url_target = "/CatTreats/findFoodItems"
            }
            
            break
        default:
            break
        }
        
        
        let parameters: Parameters = [
            "page_no": 0,
            "include": appDelegate.before_item_list_filter.include,
            "exclude": appDelegate.before_item_list_filter.exclude
        ]
        
        Alamofire.request(appDelegate.url + url_target, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success:

                var jsonResult = response.result.value as! Dictionary<String, AnyObject>
                
                appDelegate.itemCount = jsonResult["count"] as! Int
                
                let data = (jsonResult["data"] as! NSArray) as Array
                
                var jsonData = [[String:Any]]()
                
                for json in data{
                    jsonData.append(json as! [String:Any])
                }
                
                
                
                for result in jsonData{

                    let formatter = DateFormatter()
                    formatter.calendar = Calendar(identifier: .iso8601)
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.timeZone = TimeZone(secondsFromGMT: 0)
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                    
                    let create = formatter.date(from: result["createdAt"] as! String)
                    let update = formatter.date(from: result["updatedAt"] as! String)
                    
                    
                    let item = DogFood(_id: result["id"] as! Int, _name: result["food_name"] as! String, _brand: result["brand"] as! String, _type: result["food_type"] as! String, _description: result["description"] as! String, _picture_name: result["food_picture_name"] as! String, _createdAt: create! , _updateAt: update!, _GA: result["GA"] as! Array, _ingredients : result["ingredients"] as! String)
                    appDelegate.dog_food_item_list.append(item)
                }
                ///////////////data parsing 후 화면 전환 하자
                ///////collection view 에 있는 refreshcontrol 잊지말자
                appDelegate.after_item_list_filter = appDelegate.before_item_list_filter
                self.getBrandList()
                
                
                
                break
            case .failure(let error):

                HUD.flash(.error, delay: 1.0) { finished in

                    print("error here")
                }
                break
            }
        
        }
        
    }
    func getBrandList(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let headers: HTTPHeaders = [
            //            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            //            "Accept": "application/json"
            "Content-Type" : "application/json"
        ]
        
        var url_target = ""
        switch appDelegate.after_item_list_filter.pet_type {
        case 0 :
            if(appDelegate.after_item_list_filter.item_type == 0 ){
                url_target = "/DogFood/get_brands"
            }else{
                url_target = "/DogTreats/get_brands"
            }
            
            
            break
        case 1 :
            if(appDelegate.after_item_list_filter.item_type == 0 ){
                url_target = "/CatFood/get_brands"
            }else{
                url_target = "/CatTreats/get_brands"
            }
            
            break
        default:
            break
        }
        
    
        Alamofire.request(appDelegate.url + url_target, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseString { response in
            
            switch response.result {
            case .success:
                
                
                
                let data = response.value
                
                for brand in data!.components(separatedBy: ","){
                    appDelegate.brand_list.append(brand)
                }
                
                
                HUD.flash(.success, delay: 1.0) { finished in
                    appDelegate.after_item_list_filter = appDelegate.before_item_list_filter
                    
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    
                    let menuButton04VC = storyBoard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
                    
                    self.navigationController?.pushViewController(menuButton04VC, animated: true)
                    
                }
                
                break
            case .failure(let error):
                HUD.flash(.error, delay: 1.0) { finished in
                    // Completion Handler
                    print("check point")
                }
                break
            }
            
        }
        
    }

}

extension FilterVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

        selected = indexPath.row
        contentsListContainer?.reloadData()
        contentsListContainer?.layoutIfNeeded()
        
        contentsListContainer?.setContentOffset(CGPoint(x: 0, y: (contentsListContainer?.contentInset.top)!), animated: false)
    }
}

extension FilterVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ((category?.count)!+1)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sideTabCellId, for: indexPath as IndexPath) as! SideTabCell
        
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
extension FilterVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: sideTabContainer!.frame.width, height: sideTabContainer!.frame.height/6)
    }
}
extension FilterVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y

        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        if(contentOffset < 0 ){
            scrollView.contentOffset.y = 0
        }
        if maxOffset - contentOffset < 0 && maxOffset > 0 {
            scrollView.contentOffset.y = maxOffset
        }

        
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        let text = selected == 0 ? allList?[indexPath.row].content : category?[selected-1].contents?[indexPath.row].content
        let width = tableView.frame.width - 2 * sectionWidth
        let margin : CGFloat = (tableView.frame.width - 2*sectionWidth ) * 0.05
        
        if tableFont != nil {
            if widthOfText(font: tableFont!, text: text!) > width - margin {
                return rowSize * 1.4
                
            }
        }
        
        return rowSize
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){

        
    }
}
extension FilterVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if selected == 0 {
            return (allList?.count)!
        }else {
            return (category?[selected-1].contents!.count)!
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }
    func findCategoryFromAll(row : Int) -> Content{
        var index = row
        var section = 0
        while (category?[section].contents?.count)! < index {
            section = section + 1
            index = index - (category?[section].contents?.count)!
        }
        
        return (category?[section].contents?[index])!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellId, for: indexPath) as! FilterCell
        

        
        
        
        let tap = checkTabGestureRecognizer(target: self, action: #selector(self.clickIncludeOrExclude(gestureRecognizer:)))
        tap.index = indexPath.row
        tap.selected = selected
        tap.type = 0
        tap.numberOfTapsRequired = 1
        tap.cancelsTouchesInView = false
        cell.includeMark.addGestureRecognizer(tap)
        
        let tap2 = checkTabGestureRecognizer(target: self, action: #selector(self.clickIncludeOrExclude(gestureRecognizer:)))
        tap2.index = indexPath.row
        tap2.selected = selected
        tap2.type = 1
        tap2.numberOfTapsRequired = 1
        tap2.cancelsTouchesInView = false
        cell.excludeMark.addGestureRecognizer(tap2)
        
        cell.selectionStyle = .none
        
        if selected == 0 {
            let data = (category?[(allList?[indexPath.row].section)!])!.contents?[(allList?[indexPath.row].index)!]
            cell.label.text = allList?[indexPath.row].content
            cell.label.font = tableFont
            
            if !((data?.include)!) {
                cell.includeMark.alpha = 0.1
            }else {
                cell.includeMark.alpha = 1
            }
            
            if !((data?.exclude)!) {
                cell.excludeMark.alpha = 0.1
            }else {
                cell.excludeMark.alpha = 1
            }
            
        }else {
            
            let data = category?[selected-1].contents?[indexPath.row]
            cell.label.text = data?.content
            cell.label.font = tableFont
            if !((data?.include)!) {
                cell.includeMark.alpha = 0.1
            }else {
                cell.includeMark.alpha = 1
            }
            
            if !((data?.exclude)!) {
                cell.excludeMark.alpha = 0.1
            }else {
                cell.excludeMark.alpha = 1
            }
            
        }
        cell.setupCell(_sectionWidth: sectionWidth, _rowHeight : rowSize)
        cell.drawLine(_sectionWidth: sectionWidth)
        
        return cell
        
    }
    
    func clickIncludeOrExclude(gestureRecognizer: checkTabGestureRecognizer) {

        let selected = (gestureRecognizer.selected)!
        let row = (gestureRecognizer.index)!
        switch (gestureRecognizer.type)! {
            case 0:
                
                if gestureRecognizer.selected == 0 {

                    let data = category?[(allList?[row].section)!].contents?[(allList?[row].index)!]
                    category?[(allList?[row].section)!].contents?[(allList?[row].index)!].include = !(data?.include)!
                    
                    if (data?.include)! && (data?.exclude)! {
                        category?[(allList?[row].section)!].contents?[(allList?[row].index)!].exclude = false
                    }
                }else {
                    let data = (category?[selected-1].contents?[row])!
                    data.include = !data.include
                    if data.include && data.exclude {
                        data.exclude = false
                    }
                }
                
                break
            case 1:
                if gestureRecognizer.selected == 0 {
                    
                    let data = category?[(allList?[row].section)!].contents?[(allList?[row].index)!]
                    data?.exclude = !(data?.exclude)!
                    if (data?.exclude)! && (data?.include)! {
                        data?.include = false
                    }
                }else {
                    let data = (category?[selected-1].contents?[row])!
                    data.exclude = !data.exclude
                    if data.exclude && data.include {
                        data.include = false
                    }
                }
                break
            default:
                
            break
                
        }
        self.contentsListContainer?.reloadData()
        
    }
}
class checkTabGestureRecognizer : UITapGestureRecognizer {
    var selected : Int?
    var index : Int?
    var type : Int? // 0 : include  1 : exclude
    
    
    
    
}
class SideTabCell : UICollectionViewCell{
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
class FilterCell : UITableViewCell
{
    var label : UILabel!
    var excludeMark : UIImageView!
    var includeMark : UIImageView!
    var setting = false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label = UILabel()
        label.numberOfLines = 2
        excludeMark = UIImageView()
        includeMark = UIImageView()
        
        label?.translatesAutoresizingMaskIntoConstraints = false
        excludeMark?.translatesAutoresizingMaskIntoConstraints = false
        includeMark.translatesAutoresizingMaskIntoConstraints = false
        
        let origImage = UIImage(named: "check")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        includeMark.image = tintedImage
        includeMark.tintColor = myColor.mainGageColor
        excludeMark.image = tintedImage
        excludeMark.tintColor = myColor.excludeLabelColor
        
        includeMark.isUserInteractionEnabled = true
        excludeMark.isUserInteractionEnabled = true
        
        self.addSubview(label!)
        self.addSubview(excludeMark!)
        self.addSubview(includeMark)
        
        
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupCell(_sectionWidth : CGFloat, _rowHeight : CGFloat){
        if setting {
            return
        }
        
        let width = self.frame.width - 2 * _sectionWidth
        let margin : CGFloat = (self.frame.width - 2*_sectionWidth ) * 0.05
        
        label?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        label?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        label?.widthAnchor.constraint(equalToConstant: width - margin).isActive = true
        
        let imageWidth = self.frame.height * 0.6
        excludeMark.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -0.5 * (_sectionWidth - imageWidth) ).isActive = true
        excludeMark.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        excludeMark.heightAnchor.constraint(equalToConstant: _rowHeight * 0.6).isActive = true
        excludeMark.widthAnchor.constraint(equalToConstant: _rowHeight * 0.6).isActive = true
        excludeMark.contentMode = .scaleAspectFit
        
        includeMark.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -_sectionWidth - 0.5 * (_sectionWidth - imageWidth) ).isActive = true
        includeMark.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        includeMark.heightAnchor.constraint(equalToConstant: _rowHeight * 0.6).isActive = true
        includeMark.widthAnchor.constraint(equalToConstant: _rowHeight * 0.6).isActive = true
        includeMark.contentMode = .scaleAspectFit
        
        
        setting = true
        
    }
    func drawLine(_sectionWidth : CGFloat){
        let thickness : CGFloat = 0.5
        let line01 = CALayer()
        line01.frame = CGRect(x: self.frame.width - _sectionWidth - 0.5 * thickness, y: 0, width: thickness, height: self.frame.height)
        line01.backgroundColor = UIColor.gray.cgColor
        
        let line02 = CALayer()
        line02.frame = CGRect(x: self.frame.width - _sectionWidth * 2 - 0.5 * thickness, y: 0, width: thickness, height: self.frame.height)
        line02.backgroundColor = UIColor.gray.cgColor
        
        self.layer.addSublayer(line01)
        self.layer.addSublayer(line02)
    }
    
}
