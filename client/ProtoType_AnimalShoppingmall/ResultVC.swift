//
//  ResultVC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 22..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import PKHUD

class ResultVC: UIViewController {

    var page_no = 0
    var filtered_page_no = 0;
    
    @IBOutlet weak var topbarContainer: UIToolbar!
    @IBOutlet weak var itemContainer: UICollectionView!
    var sideSlideMenuBar : SideSlideMenuBar?
    var refresher : UIRefreshControl?
    var isLoading : Bool = false
    var prevScoll : CGFloat = 0.0
//    var footerView:RefreshFooterView?
    var refreshView : RefreshFooterView?
    var isFiltered = false
    var isKeyboard = false
    var isThumbView = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var refreshViewHeight : CGFloat = 50
//    let footerViewReuseIdentifier = "RefreshFooterView"
    var keyboardHideTap : UITapGestureRecognizer?
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Do any additional setup after loading the view.
//        var test = SideSlideMenuBar()
//        
//        test.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(test)
//        test.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        test.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        test.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        test.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        setupTopbar()
        setupItemContainer()
        
        sideSlideMenuBar = SideSlideMenuBar(viewController: self)
        
        setupRefreshUI()
        
        setupHomeButon()
        
        setupHideKeyboard()
    }
    func setupHideKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillAppear(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillDisappear(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        keyboardHideTap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard(recognizer:)))
        keyboardHideTap?.numberOfTapsRequired = 1
        
        print("isUserInteraction  \(self.view.isUserInteractionEnabled)")
        
    }
    
    func keyboardWillAppear(notification: NSNotification){
        isKeyboard = true

        self.view.addGestureRecognizer(keyboardHideTap!)
        
    }
    
    func keyboardWillDisappear(notification: NSNotification){
        isKeyboard = false
        self.view.removeGestureRecognizer(keyboardHideTap!)
    }
    
    func hideKeyboard(recognizer : UITapGestureRecognizer) {

        self.view.endEditing(true)
    }
    
    func filteredResult(_search : String, brands : [String], types : [String]){
        if _search.characters.count == 0 && brands.count == 0 && types.count == 0 {
            if isFiltered {
                isFiltered = false
                itemContainer.reloadData()
                itemContainer.layoutIfNeeded()
            }
            sideSlideMenuBar?.hideSideSlideMenuBar()
        }else{
            if isFiltered {
                var isSame = true
                
                if _search != appDelegate.filteredCategory.search || brands.count != appDelegate.filteredCategory.brands.count || types.count != appDelegate.filteredCategory.types.count {
                    print("check 1")
                    loadFilteredItemList(search: _search, brands: brands, types: types)
                }else{
                    for data in brands{
                        if !appDelegate.filteredCategory.brands.contains(data){
                            isSame = false
                        }
                    }
                    for data in types{
                        if !appDelegate.filteredCategory.types.contains(data){
                            isSame = false
                        }
                    }
                    
                    if isSame {
                        print("check 2")
                        sideSlideMenuBar?.hideSideSlideMenuBar()
                    }else{
                        print("check 3")
                        loadFilteredItemList(search: _search, brands: brands, types: types)
                    }
                }
                
            }else{
                loadFilteredItemList(search: _search, brands: brands, types: types)
            }
        }
    }
    func initFilter(){
        if isFiltered {
            isFiltered = false
            itemContainer.reloadData()
            itemContainer.layoutIfNeeded()
        }
        sideSlideMenuBar?.hideSideSlideMenuBar()
    }
    func loadFilteredItemList(search : String, brands : [String], types : [String]){
        
        HUD.show(.progress)
        
        let headers: HTTPHeaders = [
            //            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            //            "Accept": "application/json"
            "Content-Type" : "application/json"
        ]
        
        var url_target = ""
        switch appDelegate.after_item_list_filter.pet_type {
        case 0 :
            if appDelegate.after_item_list_filter.item_type == 0 {
                url_target = "/DogFood"
            }else {
                url_target = "/DogTreats"
            }
            
            break
        case 1 :
            if appDelegate.after_item_list_filter.item_type == 0 {
                url_target = "/CatFood"
            }else {
                url_target = "/CatTreats"
            }
            
            break
        default:
            break
        }
        url_target += "/findFilteredFoodItems"
        
        var parameters: Parameters = [
            "page_no": 0,
            "include": appDelegate.after_item_list_filter.include,
            "exclude": appDelegate.after_item_list_filter.exclude
        ]
        var brand : String = ""
        for data in brands {
            if brand.characters.count == 0 {
                brand = data
            }else{
                brand += ",\(data)"
            }
        }
        parameters["brands"] = brand
        var type : String = ""
        for data in types {
            if type.characters.count == 0 {
                type = data
            }else {
                type += ",\(data)"
            }
        }
        parameters["types"] = type
        parameters["search"] = search
        
        Alamofire.request(appDelegate.url + url_target, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success:
                //print(response.response?.statusCode)
                //print("Validation Successful")
                //print(response.result.value)
                //print("///////////////")
                
                //var result = response.result.value as! Dictionary<<#Key: Hashable#>, Any>
                var jsonResult = response.result.value as! Dictionary<String, AnyObject>
                
                self.appDelegate.filteredCategory.count = jsonResult["count"] as! Int
                
                var data = (jsonResult["data"] as! NSArray) as Array
                
                var jsonData = [[String:Any]]()
                
                for json in data{
                    jsonData.append(json as! [String:Any])
                }
                
                self.appDelegate.filteredCategory.filteredItemList.removeAll()
                
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
                    
                    self.appDelegate.filteredCategory.filteredItemList.append(item)
                    
                }
                
                self.isFiltered = true
                self.filtered_page_no = 0
                self.appDelegate.filteredCategory.brands.removeAll()
                self.appDelegate.filteredCategory.brands = brands
                self.appDelegate.filteredCategory.search = search
                self.appDelegate.filteredCategory.types.removeAll()
                self.appDelegate.filteredCategory.types = types
                self.itemContainer.reloadData()
                
                
                HUD.flash(.success, delay: 1.0)
                self.sideSlideMenuBar?.hideSideSlideMenuBar()
                
                break
            case .failure(let error):
                //print(error)
                //print(response.response?.statusCode)
                
                HUD.flash(.error, delay: 1.0)
                
                self.loadFinish(success: false)
                break
            }
            
        }
    }
    func setupTopbar(){
        var heightConstant = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        if (self.navigationController != nil) {
            heightConstant += (self.navigationController?.navigationBar.frame.height)!
        }
        topbarContainer.translatesAutoresizingMaskIntoConstraints = false
        topbarContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        topbarContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        topbarContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: heightConstant).isActive = true
        topbarContainer.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.08).isActive = true
        topbarContainer.barTintColor = UIColor.white
        let categorize = UIButton()
        

        categorize.setTitle("filter", for: .normal)
        categorize.setTitleColor(UIColor.white, for: .normal)
        categorize.translatesAutoresizingMaskIntoConstraints = false
        categorize.backgroundColor = myColor.deselectedSideTabnColor
        categorize.layer.cornerRadius = 3
        topbarContainer.addSubview(categorize)
        categorize.centerYAnchor.constraint(equalTo: topbarContainer.centerYAnchor).isActive = true
        categorize.rightAnchor.constraint(equalTo: topbarContainer.rightAnchor, constant: -0.05*self.view.frame.width).isActive = true
        categorize.heightAnchor.constraint(equalTo: topbarContainer.heightAnchor, multiplier: 0.75).isActive = true
        categorize.widthAnchor.constraint(equalTo: topbarContainer.widthAnchor, multiplier: 0.15).isActive = true
        categorize.addTarget(self, action: #selector(self.OnCSButton(_:)), for: .touchUpInside)
        
        categorize.layoutIfNeeded()
        
        categorize.titleLabel?.font = UIFont.systemFont(ofSize: findIconLabelSize(height: categorize.frame.height*0.5, label: categorize.titleLabel!))
        let viewMode = UIButton(type: .custom)
        viewMode.setImage(UIImage(named: "thumbnail_icon"), for: .normal)
        viewMode.contentMode = .scaleAspectFill
        viewMode.translatesAutoresizingMaskIntoConstraints = false
        
        topbarContainer.addSubview(viewMode)
        viewMode.centerYAnchor.constraint(equalTo: topbarContainer.centerYAnchor).isActive = true
        viewMode.heightAnchor.constraint(equalTo: topbarContainer.heightAnchor, multiplier: 0.6).isActive = true
        viewMode.widthAnchor.constraint(equalTo: viewMode.heightAnchor).isActive = true
        
        viewMode.rightAnchor.constraint(equalTo: categorize.leftAnchor, constant: -0.05*self.view.frame.width).isActive = true
        
        viewMode.addTarget(self, action: #selector(self.clickedViewIcon(_:)), for: .touchUpInside)
        
    }
    func clickedViewIcon(_ sender : UIButton){
        isThumbView = !isThumbView
        if isThumbView {
            sender.setImage(UIImage(named: "list_icon"), for: .normal)
        }else{
            sender.setImage(UIImage(named: "thumbnail_icon"), for: .normal)
        }
        itemContainer.reloadData()
    }
    
    func setupItemContainer(){
        
        
        itemContainer.translatesAutoresizingMaskIntoConstraints = false
        
        itemContainer.backgroundColor = UIColor.gray
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = self.view.frame.width/2
        let height = (width/3)*4 * 1.2
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        itemContainer!.collectionViewLayout = layout
     
        itemContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        itemContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        itemContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        itemContainer.topAnchor.constraint(equalTo: topbarContainer.bottomAnchor, constant: -2).isActive = true
        
        
    }
    func setupHomeButon(){
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(clickedHome(sender:)))
    }
    func clickedHome(sender : UIBarButtonItem){
        
        let nextViewController = self.navigationController?.viewControllers[0] as! ViewController
        self.navigationController?.popToViewController(nextViewController, animated: true)
    }
    func setupRefreshUI(){
//        let refreshControlView = UIRefreshControl()
//        self.itemContainer.alwaysBounceVertical = true
//        refreshControlView.addTarget(self, action: #selector(self.RefreshResult), for: UIControlEvents.valueChanged)
//        
//        self.itemContainer.refreshControl = refreshControlView
        
//        self.itemContainer.register(UINib(nibName: "RefreshFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerViewReuseIdentifier)
//        
//        
//        self.itemContainer.layoutIfNeeded()
//        testView = UIView()
//        testView?.backgroundColor = UIColor.blue
//        testView?.frame = CGRect(x: 0, y: self.itemContainer.contentSize.height, width: self.itemContainer.bounds.width, height: 55)
//        self.itemContainer.addSubview(testView!)
//        print("contentSize : \(self.itemContainer.contentSize)")
        
        self.itemContainer.layoutIfNeeded()
        self.refreshView = RefreshFooterView(frame: CGRect(x: 0, y: self.itemContainer.contentSize.height, width: self.itemContainer.bounds.width, height: self.refreshViewHeight))
        self.refreshView?.backgroundColor = UIColor.clear
        
        self.itemContainer.addSubview(self.refreshView!)

        
    }
    func RefreshResult(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func OnCSButton(_ sender : UIButton){

        sideSlideMenuBar?.showSideSlideMenuBar()
    }
    
    func loadFinish( success : Bool){
        if success {
            if isFiltered {
                filtered_page_no += 1
            }else{
                page_no += 1
            }
            
            self.itemContainer.reloadData()
            self.itemContainer.layoutIfNeeded()
            self.refreshView?.frame = CGRect(x: 0, y: self.itemContainer.contentSize.height, width: self.itemContainer.bounds.width, height: self.refreshViewHeight)
            
        }else{
            
           
        }
        self.refreshView?.stopAnimate()
        self.isLoading = false
        
    }
    
    func loadFoodItems(){
        self.refreshView?.startAnimate()
        
        
        
       
        
        let headers: HTTPHeaders = [
            //            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            //            "Accept": "application/json"
            "Content-Type" : "application/json"
        ]
        
        var url_target = ""
        switch appDelegate.after_item_list_filter.pet_type {
        case 0 :
            if appDelegate.after_item_list_filter.item_type == 0 {
                url_target = "/DogFood"
            }else {
                url_target = "/DogTreats"
            }
            
            break
        case 1 :
            if appDelegate.after_item_list_filter.item_type == 0 {
                url_target = "/CatFood"
            }else {
                url_target = "/CatTreats"
            }
            
            break
        default:
            break
        }
        url_target += !isFiltered ? "/findFoodItems" : "/findFilteredFoodItems"
        
        var parameters: Parameters = [
            "page_no": (!isFiltered ? page_no : filtered_page_no) + 1,
            "include": appDelegate.after_item_list_filter.include,
            "exclude": appDelegate.after_item_list_filter.exclude
        ]
        if isFiltered {
            var brand : String = ""
            for data in appDelegate.filteredCategory.brands {
                if brand.characters.count == 0 {
                    brand = data
                }else{
                    brand += ",\(data)"
                }
            }
            parameters["brands"] = brand
            var types : String = ""
            for data in appDelegate.filteredCategory.types {
                if types.characters.count == 0 {
                    types = data
                }else {
                    types += ",\(data)"
                }
            }
            parameters["types"] = types
            parameters["search"] = appDelegate.filteredCategory.search
            
        }
        
        Alamofire.request(appDelegate.url + url_target, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success:
                //print(response.response?.statusCode)
                //print("Validation Successful")
                //print(response.result.value)
                //print("///////////////")
                
                //var result = response.result.value as! Dictionary<<#Key: Hashable#>, Any>
                var jsonResult = response.result.value as! Dictionary<String, AnyObject>
                
                self.appDelegate.itemCount = jsonResult["count"] as! Int
                
                var data = (jsonResult["data"] as! NSArray) as Array
                
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
                    
                    if !self.isFiltered{
                        self.appDelegate.dog_food_item_list.append(item)
                    }else{
                        self.appDelegate.filteredCategory.filteredItemList.append(item)
                    }
                    
                }
                ///////////////data parsing 후 화면 전환 하자
                ///////collection view 에 있는 refreshcontrol 잊지말자
                self.loadFinish(success: true)
                
                break
            case .failure(let error):
                //print(error)
                //print(response.response?.statusCode)
                self.loadFinish(success: false)
                break
            }
            
        }
    }
}

extension ResultVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

        
        appDelegate.selected_item = !isFiltered ? appDelegate.dog_food_item_list[indexPath.row] : appDelegate.filteredCategory.filteredItemList[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        
        let selectedItemVC = storyBoard.instantiateViewController(withIdentifier: "SelectedItemVC") as! SelectedItemVC
        
        self.navigationController?.pushViewController(selectedItemVC, animated: true)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView){
//        let offset = scrollView.contentOffset.y
//        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        print("height : \(scrollView.contentSize.height)" )
//        print("content offset y  \(scrollView.contentOffset.y)")
//        if (maxOffset - offset) <= 0 {
//            
//            refresher?.beginRefreshing()
//            
//            print(refresher?.frame)
////            if (!self.isLoading) {
////                self.isLoading = true
////
////            }
//        }
//    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;

        
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
//        print(" diff Height : \(diffHeight)")
//        print(" maxOffset : \(maxOffset)")
//        print(" check point : \(maxOffset - contentOffset)")
//        print(" content Offset : \(contentOffset)")
        var itemCount = !isFiltered ? appDelegate.itemCount : appDelegate.filteredCategory.count
        var currCount = !isFiltered ? appDelegate.dog_food_item_list.count : appDelegate.filteredCategory.filteredItemList.count
        if(contentOffset < 0 ){
            scrollView.contentOffset.y = 0
        }
        
        if maxOffset - contentOffset < 0 && itemCount <= currCount {
            scrollView.contentOffset.y = maxOffset
        }
        
        if maxOffset - contentOffset < 0 && refreshViewHeight < contentOffset - maxOffset
        {
            
            scrollView.contentOffset.y = maxOffset + refreshViewHeight
        }
        
        if !isLoading && prevScoll - contentOffset < 0 && refreshViewHeight * 0.66 < contentOffset - maxOffset && itemCount > currCount {
            
            
            isLoading = true
            
            print("Loading!!!")
            self.loadFoodItems()
        }
        
        
        
        prevScoll = contentOffset
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}

extension ResultVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        if isThumbView {
            return CGSize(width: itemContainer!.frame.width/2, height: self.view.frame.height*0.41)
        }else{
            return CGSize(width: itemContainer!.frame.width, height: self.view.frame.height*0.23)
        }
        
        
    }
}

extension ResultVC : UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! itemCollectionCell
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.5
        
        

        let item = !isFiltered ? appDelegate.dog_food_item_list[indexPath.row] : appDelegate.filteredCategory.filteredItemList[indexPath.row]
        //cell.itemImage.image = UIImage(named: "food_icon")
        

        
        cell.itemName.text = item.name
        cell.itemImageName = item.picture_name
        cell.itemType.text = "Food Type : \(item.type)"
        cell.itemBrand.text = item.brand
        cell.itemPrimaryIngredient.text = "Primary Ingredient : \(item.ingredients[0].name)"
        cell.thumbName.text = item.name
        if isThumbView {
            cell.setThumbInit()
            cell.downloadImageForThumb(_row: indexPath.row, _isFiltered: isFiltered)
            
        }else{
            cell.setListInit()
            cell.downloadImageForList(_row: indexPath.row, _isFiltered: isFiltered)
        }
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{

        return !isFiltered ? appDelegate.dog_food_item_list.count : appDelegate.filteredCategory.filteredItemList.count
    }
}

class itemCollectionCell : UICollectionViewCell{
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemBrand: UILabel!
    @IBOutlet weak var itemType: UILabel!
    @IBOutlet weak var itemPrimaryIngredient: UILabel!
    @IBOutlet weak var thumbName: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var itemImageName : String = ""
    var Image : UIImage?
    var tryCount = 0
    var maxTryCount = 5
    var isSettingThumb = false
    var isSettingList = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    func setup(){
        
    }
    func setThumbInit(){
        itemImage.isHidden = true
        itemName.isHidden = true
        itemBrand.isHidden = true
        itemType.isHidden = true
        itemPrimaryIngredient.isHidden = true
        
        thumbImage.isHidden = false
        thumbName.isHidden = false
        
        if isSettingThumb
        {
            return
        }
        
        thumbImage.translatesAutoresizingMaskIntoConstraints = false
        thumbName.translatesAutoresizingMaskIntoConstraints = false
        
        thumbImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        thumbImage.widthAnchor.constraint(equalTo: thumbImage.heightAnchor, multiplier: 3/4).isActive = true
        
        
        thumbImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -self.frame.height*0.034).isActive = true
        
        
        thumbImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        
        
        
        thumbName.textColor = UIColor.gray
        
        thumbName.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        thumbName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        thumbName.textAlignment = .center
        thumbName.textColor = UIColor.black
        
        self.layoutIfNeeded()
        
        let space = self.frame.height - (thumbImage.frame.origin.y + thumbImage.frame.height)

//        itemName.font = UIFont.systemFont(ofSize: findIconLabelSize(height: nameHeightConstHelper, label: itemName))
        let constantHelp = thumbImage.frame.origin.y + thumbImage.frame.height
        thumbName.topAnchor.constraint(equalTo: self.topAnchor, constant: constantHelp + space/3).isActive = true
        
        thumbName.heightAnchor.constraint(equalToConstant: space*0.28).isActive = true
        self.layoutIfNeeded()
        thumbName.font = UIFont(name: "Helvetica-CondensedBlack", size: 14)
        thumbName.font = UIFont(name: "Helvetica-CondensedBlack", size: findIconLabelSize(height : thumbName.frame.height, label : thumbName, font : "Helvetica-CondensedBlack"))
        
        isSettingThumb = true

    }
    func setListInit(){
        
        itemImage.isHidden = false
        itemName.isHidden = false
        itemBrand.isHidden = false
        itemType.isHidden = false
        itemPrimaryIngredient.isHidden = false
        
        thumbImage.isHidden = true
        thumbName.isHidden = true
        
        if isSettingList {
            return
        }
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemName.translatesAutoresizingMaskIntoConstraints = false
        itemBrand.translatesAutoresizingMaskIntoConstraints = false
        itemType.translatesAutoresizingMaskIntoConstraints = false

        itemPrimaryIngredient.translatesAutoresizingMaskIntoConstraints = false
        
        itemImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        itemImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width*0.1).isActive = true
        itemImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.18).isActive = true
        itemImage.heightAnchor.constraint(equalTo: itemImage.widthAnchor, multiplier: 4/3).isActive = true
        itemImage.layoutIfNeeded()
        itemName.textAlignment = .left
        itemName.topAnchor.constraint(equalTo: itemImage.topAnchor , constant: itemImage.frame.height*0.1).isActive = true
        itemName.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: self.frame.width*0.11).isActive = true
        itemName.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -self.frame.width*0.05).isActive = true
        itemName.heightAnchor.constraint(equalTo: itemImage.heightAnchor, multiplier: 0.225).isActive = true
        
        itemBrand.topAnchor.constraint(equalTo: itemName.bottomAnchor , constant: itemImage.frame.height*0.03).isActive = true
        itemBrand.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: self.frame.width*0.11).isActive = true
        itemBrand.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -self.frame.width*0.05).isActive = true
        itemBrand.heightAnchor.constraint(equalTo: itemImage.heightAnchor, multiplier: 0.15).isActive = true
        
        itemType.topAnchor.constraint(equalTo: itemBrand.bottomAnchor , constant: itemImage.frame.height*0.04).isActive = true
        itemType.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: self.frame.width*0.11).isActive = true
        itemType.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -self.frame.width*0.05).isActive = true
        itemType.heightAnchor.constraint(equalTo: itemImage.heightAnchor, multiplier: 0.13).isActive = true
        
        itemPrimaryIngredient.topAnchor.constraint(equalTo: itemType.bottomAnchor , constant: itemImage.frame.height*0.03).isActive = true
        itemPrimaryIngredient.leftAnchor.constraint(equalTo: itemImage.rightAnchor, constant: self.frame.width*0.11).isActive = true
        itemPrimaryIngredient.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.frame.width*0.05).isActive = true
        itemPrimaryIngredient.heightAnchor.constraint(equalTo: itemImage.heightAnchor, multiplier: 0.13).isActive = true
        
        self.layoutIfNeeded()
        
        itemName.font = UIFont(name: "Helvetica-CondensedBlack", size: 14)
        itemName.font = UIFont(name: "Helvetica-CondensedBlack", size: findIconLabelSize(height : itemName.frame.height, label : itemName, font : "Helvetica-CondensedBlack"))
        itemBrand.font = UIFont(name: "Helvetica-CondensedBlack", size: 14)
        itemBrand.font = UIFont(name: "Helvetica-CondensedBlack", size: findIconLabelSize(height : itemBrand.frame.height, label : itemBrand, font : "Helvetica-CondensedBlack"))
        itemBrand.textColor = myColor.deselectedSideTabnColor
        
        itemType.font = UIFont(name: "Franklin Gothic Medium", size: 14)
        itemType.font = UIFont(name: "Franklin Gothic Medium", size: findIconLabelSize(height : itemType.frame.height, label : itemType, font : "Franklin Gothic Medium"))
        itemPrimaryIngredient.font = UIFont(name: "Franklin Gothic Medium", size: 14)
        itemPrimaryIngredient.font = UIFont(name: "Franklin Gothic Medium", size: findIconLabelSize(height : itemPrimaryIngredient.frame.height, label : itemPrimaryIngredient, font : "Franklin Gothic Medium"))
        

        isSettingList = true

        
    }
    func downloadImageForThumb(_row : Int, _isFiltered : Bool){

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var url = appDelegate.url
        
        //print("Ori : \(appDelegate.dog_food_item_list[_row].picture_name) Cell : \(itemImageName)")
        
        switch appDelegate.after_item_list_filter.pet_type {
        case 0 :
            if(appDelegate.after_item_list_filter.item_type == 0){
                url += "/DogFood/loadImage/" + itemImageName
            }else{
                url += "/DogTreats/loadImage/" + itemImageName
            }
            
            break
        case 1 :
            if(appDelegate.after_item_list_filter.item_type == 0){
                url += "/CatFood/loadImage/" + itemImageName
            }else{
                url += "/CatTreats/loadImage/" + itemImageName
            }
            
            break
        default:
            break
        }
        let item = !_isFiltered ?  appDelegate.dog_food_item_list[_row] : appDelegate.filteredCategory.filteredItemList[_row]
        
        if(item.item_image == nil){
            thumbImage.af_setImage(withURL: URL(string: url)!,
                                  placeholderImage: UIImage(named: "food_icon")){
                                    response in
                                    //print("check " + self.itemImageName)
                                    item.item_image = response.value
            }
        }else{
            thumbImage.image = item.item_image
        }
        

    }
    func downloadImageForList(_row : Int, _isFiltered : Bool){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var url = appDelegate.url
        
        //print("Ori : \(appDelegate.dog_food_item_list[_row].picture_name) Cell : \(itemImageName)")
        
        switch appDelegate.after_item_list_filter.pet_type {
        case 0 :
            if(appDelegate.after_item_list_filter.item_type == 0){
                url += "/DogFood/loadImage/" + itemImageName
            }else{
                url += "/DogTreats/loadImage/" + itemImageName
            }
            
            break
        case 1 :
            if(appDelegate.after_item_list_filter.item_type == 0){
                url += "/CatFood/loadImage/" + itemImageName
            }else{
                url += "/CatTreats/loadImage/" + itemImageName
            }
            
            break
        default:
            break
        }
        let item = !_isFiltered ?  appDelegate.dog_food_item_list[_row] : appDelegate.filteredCategory.filteredItemList[_row]
        
        if(item.item_image == nil){
            itemImage.af_setImage(withURL: URL(string: url)!,
                                  placeholderImage: UIImage(named: "food_icon")){
                                    response in
                                    //print("check " + self.itemImageName)
                                    item.item_image = response.value
            }
        }else{
            itemImage.image = item.item_image
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
}


