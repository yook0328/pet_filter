//
//  MenuButton04VC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 18..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit
import PKHUD
import Alamofire

class MenuButton04VC: PageSwipeTabController {
    var includeView : SubViewMenuButton04?
    var excludeView : SubViewMenuButton04?
    
    override func setupController() {
        //let include = SubViewMenuButton04(frame: .zero)
        super.setupController()
        
        includeView = SubViewMenuButton04(frame: .zero)
        includeView?.tag = 0
        includeView?.delegate = self
        includeView?.mark = UIImage(named: "exclude_mark")
        addTabView(_item : PageTabItem(_view : includeView! , _title : "include"))
        
        excludeView = SubViewMenuButton04(frame: .zero)
        excludeView?.tag = 1
        excludeView?.delegate = self
        excludeView?.mark = UIImage(named: "include_mark")
        addTabView(_item : PageTabItem(_view : excludeView! , _title : "exclude"))
        
        
//        let view = UIView()
//        view.backgroundColor = UIColor.blue
//        addTabView(_view: view)
        let path = NSIndexPath(row: 0, section: 0)
        includeView?.sideTabContainer?.selectItem(at: path as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        excludeView?.sideTabContainer?.selectItem(at: path as IndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        setupSearchButton()
        setupHomeButon()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        resetItems()
    }
    override func setupCell(cell: PageCell) {
        super.setupCell(cell: cell)
        
//        let view = cell.page as! SubViewMenuButton04
//        view.sideTabContainer?.reloadData()
//        view.contentsListContainer?.reloadData()
        
    }
    
    override func setupTabBarIcon(cell : TabCell, index : Int){

//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        cell.addSubview(label)
//        label.text = tabViews[index].title
//        
//        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor)
//        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor)
        
        
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
        
//        button.layer.borderColor = UIColor.black.cgColor
//        button.layer.borderWidth = 2
        
        
        
        let buttonSize = self.view.frame.width/4
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -buttonSize*0.2).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -buttonSize*0.2).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
//        button.layer.cornerRadius = buttonSize*0.5
        //button.layer.cornerRadius = 50*0.5
        
//        let shadow = UIView()
//        shadow.translatesAutoresizingMaskIntoConstraints = false
//        button.addSubview(shadow)
//        shadow.backgroundColor = UIColor.black
//        shadow.alpha = 0.3
//        shadow.isOpaque = true
//        
//        shadow.centerXAnchor.constraint(equalTo: button.centerXAnchor, constant: 5).isActive = true
//        shadow.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 5).isActive = true
//        shadow.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true
//        shadow.widthAnchor.constraint(equalTo: button.widthAnchor).isActive = true
//        
//        shadow.layer.cornerRadius = buttonSize*0.5
        //shadow.layer.cornerRadius = 50*0.5
//        
//        button.sendSubview(toBack: shadow)
        //self.view.bringSubview(toFront: button)
        label.layoutIfNeeded()
        label.font = UIFont.systemFont(ofSize: findIconLabelSize(height: label.frame.height, label: label))
        button.addTarget(self, action: #selector(onSearchAction), for: .touchUpInside)
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
    
    func onSearchAction(sender: UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        for contents in (includeView?.category)!
        {
            for content in contents.contents!
            {
                if content.selected
                {
                    if appDelegate.before_item_list_filter.include.characters.count > 0 {
                        appDelegate.before_item_list_filter.include += "," + content.content
                    }else{
                        appDelegate.before_item_list_filter.include = content.content
                    }
                }
            }
        }
        for contents in (excludeView?.category)!
        {
            for content in contents.contents!
            {
                if content.selected
                {
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
        
//        switch appDelegate.before_item_list_filter.item_type {
//            case 0 :
//                url_target += "/findFoodItems"
//                break
//            case 1 :
//                url_target += "/findTreats"
//                break
//            default:
//                break
//        }
        
        let parameters: Parameters = [
                "page_no": 0,
                "include": appDelegate.before_item_list_filter.include,
                "exclude": appDelegate.before_item_list_filter.exclude
            ]
        
        Alamofire.request(appDelegate.url + url_target, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
                case .success:
                    //print(response.response?.statusCode)
                    //print("Validation Successful")
                    //print(response.result.value)
                    //print("///////////////")
                    
                    //var result = response.result.value as! Dictionary<<#Key: Hashable#>, Any>
                    var jsonResult = response.result.value as! Dictionary<String, AnyObject>
                    
                    appDelegate.itemCount = jsonResult["count"] as! Int
                    
                    let data = (jsonResult["data"] as! NSArray) as Array

                    var jsonData = [[String:Any]]()
                    
                    for json in data{
                        jsonData.append(json as! [String:Any])
                    }
                    
                    
                    
                    for result in jsonData{
                        //print(result["createdAt"])
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
                    
//                    HUD.flash(.success, delay: 1.0) { finished in
//                        appDelegate.after_item_list_filter = appDelegate.before_item_list_filter
//                        
////                        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
////                        
////                        let url = appDelegate.url + "/DogFood/loadImage" +  appDelegate.dog_food_item_list[0].picture_name
////                        
////                        Alamofire.download(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, to: destination).downloadProgress(closure: { (progress) in
////                            print("Download Progress: \(progress.fractionCompleted)")
////                        }).responseData { response in
////                            if let data = response.result.value {
////                                
////                                let image = UIImage(data: data)
////                                print("finish")
////                            }
////
////                        }
//                        
////                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
////                        
////                        
////                        let menuButton04VC = storyBoard.instantiateViewController(withIdentifier: "ResultVC") as! ResultVC
////                        
////                        self.navigationController?.pushViewController(menuButton04VC, animated: true)
//
//                    }
                    
                    break
                case .failure(let error):
                    //print(error)
                    //print(response.response?.statusCode)
                    HUD.flash(.error, delay: 1.0) { finished in
                        // Completion Handler
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
        

        
        let parameters: Parameters = [
        : ]

        print(appDelegate.url + url_target)
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
                //print(error)
                //print(response.response?.statusCode)
                HUD.flash(.error, delay: 1.0) { finished in
                    // Completion Handler
                    print("check point")
                }
                break
            }
        }
    }
    
    func setupHomeButon(){
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(clickedHome(sender:)))
    }
    func clickedHome(sender : UIBarButtonItem){
        
        let nextViewController = self.navigationController?.viewControllers[0] as! ViewController
        self.navigationController?.popToViewController(nextViewController, animated: true)
    }
}
extension MenuButton04VC : FilteredTableDelegate{
    func selected(tag: Int, section : Int, content : Int){
        print("selected : \(tag)")
        if tag == 0 { //카테고리 잘 링크 시켜줄것 // 내가 선택했을시 내 마크 없앨 것
            self.excludeView?.category?[section].contents?[content].reverseSelected = true
            self.excludeView?.category?[section].contents?[content].selected = false
            self.excludeView?.contentsListContainer?.reloadData()
            self.excludeView?.contentsListContainer?.layoutIfNeeded()
        }else{
            self.includeView?.category?[section].contents?[content].reverseSelected = true
            self.includeView?.category?[section].contents?[content].selected = false
            self.includeView?.contentsListContainer?.reloadData()
            self.includeView?.contentsListContainer?.layoutIfNeeded()

        }
    }
    func deselected(tag: Int, section : Int, content : Int){
        if tag == 0 { //카테고리 잘 링크 시켜줄것 // 내가 선택했을시 내 마크 없앨 것

            self.excludeView?.category?[section].contents?[content].reverseSelected = false
            self.excludeView?.contentsListContainer?.reloadData()
            self.excludeView?.contentsListContainer?.layoutIfNeeded()
        }else{
            self.includeView?.category?[section].contents?[content].reverseSelected = false

            self.includeView?.contentsListContainer?.reloadData()
            self.includeView?.contentsListContainer?.layoutIfNeeded()
            
        }
    }
}
protocol FilteredTableDelegate {
    func selected(tag: Int, section : Int, content : Int)
    func deselected(tag: Int, section : Int, content : Int)
}


