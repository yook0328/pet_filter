//
//  SelectedItemVC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 4. 26..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit
import AlamofireImage

class SelectedItemVC: UIViewController {

    @IBOutlet weak var viewContainer: UIScrollView!
    
    var imageViewContainer : UIView?
    var imageView : UIImageView?
    var buttonBar : UIToolbar?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var infoContainer : UIView?
    var ingredientsContainer : UIView?
    var gAContainer : UIView?
    var isPad = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewContainer()
        setupImageView()
        setupButtonBar()
        setupInfoContainer()
        setupIngredientsContainer()
        setupGAContainer()
        
        setupViewContainerContentSize()
        
        setupHomeButon()
        
//        for data in (appDelegate.selected_item?.ingredients)!{
//            print(data.name)
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupViewContainerContentSize(){
        viewContainer.layoutIfNeeded()
        
        viewContainer.contentSize = CGSize(width: 0, height: (imageViewContainer?.bounds.height)! + (buttonBar?.bounds.height)! + (infoContainer?.bounds.height)! + (ingredientsContainer?.bounds.height)! + (gAContainer?.bounds.height)!)
    }
    func setupViewContainer(){
        
        /////////// scrollview delete topmargin
        self.automaticallyAdjustsScrollViewInsets = false
        viewContainer.contentInset = UIEdgeInsets.zero
        viewContainer.scrollIndicatorInsets = UIEdgeInsets.zero
        viewContainer.contentOffset = CGPoint.zero
        //////

        
//        viewContainer.isMultipleTouchEnabled = false
//        viewContainer.bouncesZoom = false
//        viewContainer.bounces = false

        viewContainer.showsHorizontalScrollIndicator = false
        
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        var heightConstant = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        if (self.navigationController != nil) {
            heightConstant += (self.navigationController?.navigationBar.frame.height)!
        }
 
        viewContainer.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        viewContainer.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        viewContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: heightConstant).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        viewContainer.layoutIfNeeded()
        viewContainer.backgroundColor = UIColor.lightGray
    }
    
    func setupImageView(){
        imageViewContainer = UIView()
        
        viewContainer.addSubview(imageViewContainer!)
        
        imageViewContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewContainer?.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        imageViewContainer?.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 0).isActive = true
        
        imageViewContainer?.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        imageViewContainer?.heightAnchor.constraint(equalTo: viewContainer.widthAnchor, multiplier: 3/4).isActive = true
        
        imageViewContainer?.backgroundColor = UIColor.white
        
        imageView = UIImageView()
        
        imageViewContainer?.addSubview(imageView!)
        
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        if appDelegate.selected_item?.item_image == nil {
            var url = appDelegate.url
            
            
            switch appDelegate.after_item_list_filter.pet_type {
            case 0 :
                if(appDelegate.after_item_list_filter.item_type == 0 ){
                    url += "/DogFood/loadImage/" + (appDelegate.selected_item?.picture_name)!
                }else{
                    url += "/DogTreats/loadImage/" + (appDelegate.selected_item?.picture_name)!
                }
                
                break
            case 1 :
                if(appDelegate.after_item_list_filter.item_type == 0 ){
                    url += "/CatTreats/loadImage/" + (appDelegate.selected_item?.picture_name)!
                }else{
                    
                }
                
                break
            default:
                break
            }
            imageView?.af_setImage(withURL: URL(string: url)!,
                                  placeholderImage: UIImage(named: "food_icon")){
                                    response in

                                    self.appDelegate.selected_item?.item_image = response.value
            }
        }else{
            imageView?.image = appDelegate.selected_item?.item_image
        }
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerXAnchor.constraint(equalTo: (imageViewContainer?.centerXAnchor)!).isActive = true
        imageView?.centerYAnchor.constraint(equalTo: (imageViewContainer?.centerYAnchor)!).isActive = true
        imageView?.heightAnchor.constraint(equalTo: (imageViewContainer?.heightAnchor)!, multiplier: 0.9).isActive = true
        imageView?.widthAnchor.constraint(equalTo: (imageViewContainer?.widthAnchor)!).isActive = true
     
    }
    func setupButtonBar(){
        
        buttonBar = UIToolbar()
        
        viewContainer.addSubview(buttonBar!)
        
        buttonBar?.translatesAutoresizingMaskIntoConstraints = false
        
        buttonBar?.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        buttonBar?.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        buttonBar?.topAnchor.constraint(equalTo: (imageViewContainer?.bottomAnchor)!).isActive = true
        buttonBar?.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.043).isActive = true
        buttonBar?.barTintColor = UIColor.white
        
        buttonBar?.layoutIfNeeded()
        
        
        
//        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
//        
//        var modifyButton = makeBarButton(size: (buttonBar?.frame.size)!, icon : "modify", text: "modify", action: #selector(onClickModify(sender:)))
//
//        
//        
//        buttonBar?.items = [flexible, modifyButton]
        
        
    }
    
    func setupInfoContainer(){
        let margin : CGFloat = 5.0
        
        
        
        let rowHeight : CGFloat = 20
        
        
        let rightMargin : CGFloat = UIScreen.main.bounds.width * 0.032
        
        infoContainer = UIView()
        viewContainer.addSubview(infoContainer!)
        infoContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        infoContainer?.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        infoContainer?.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        infoContainer?.topAnchor.constraint(equalTo: (buttonBar?.bottomAnchor)!).isActive = true
        var infoHeightConstrait = infoContainer?.heightAnchor.constraint(equalToConstant: 100)
        infoHeightConstrait?.isActive = true
        infoContainer?.backgroundColor = UIColor.white
        
        let name = UILabel()
        let brand = UILabel()
        let date = UILabel()
        
        infoContainer?.addSubview(name)
        infoContainer?.addSubview(brand)
        infoContainer?.addSubview(date)
        
        name.text = appDelegate.selected_item?.name
        name.textAlignment = .center
        
        name.translatesAutoresizingMaskIntoConstraints = false
        
        name.centerXAnchor.constraint(equalTo: (infoContainer?.centerXAnchor)!).isActive = true
        name.widthAnchor.constraint(equalToConstant: self.view.frame.width - 2*margin).isActive = true
        
        if isPad {
            print("wowowowowowowo")
            name.topAnchor.constraint(equalTo: (infoContainer?.topAnchor)!, constant: UIScreen.main.bounds.height * 0.0315).isActive = true
        }else {
            name.topAnchor.constraint(equalTo: date.bottomAnchor, constant: UIScreen.main.bounds.height * 0.02).isActive = true
        }
        
        name.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.0458).isActive = true
        
        
        brand.textAlignment = .center
        brand.textColor = myColor.deselectedSideTabnColor
        brand.text = (appDelegate.selected_item?.brand)!
        
        brand.translatesAutoresizingMaskIntoConstraints = false
        
        brand.centerXAnchor.constraint(equalTo: (infoContainer?.centerXAnchor)!).isActive = true
        brand.widthAnchor.constraint(equalToConstant: self.view.frame.width - 2*margin).isActive = true
        brand.topAnchor.constraint(equalTo: name.bottomAnchor, constant: UIScreen.main.bounds.height * 0.006).isActive = true
        brand.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03).isActive = true
        
        let typeLabel = UILabel()
        typeLabel.text = "Food Type "
        
        
        typeLabel.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: UIScreen.main.bounds.height*0.028, label: typeLabel))
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        infoContainer?.addSubview(typeLabel)
        let widthForTypeLabel = widthOfText(font: typeLabel.font, text: "Food Type ") + 4
        typeLabel.widthAnchor.constraint(equalToConstant: widthForTypeLabel).isActive = true
        typeLabel.leftAnchor.constraint(equalTo: (infoContainer?.leftAnchor)!, constant: UIScreen.main.bounds.width*0.041).isActive = true
        typeLabel.topAnchor.constraint(equalTo: brand.bottomAnchor, constant: UIScreen.main.bounds.height * 0.014).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.028).isActive = true
        
        
        
        let type = UILabel()
        type.font = UIFont.systemFont(ofSize: 13)
        type.text = (appDelegate.selected_item?.type)!
        infoContainer?.addSubview(type)
        type.translatesAutoresizingMaskIntoConstraints = false
        
        type.leftAnchor.constraint(equalTo: typeLabel.rightAnchor).isActive = true
        type.widthAnchor.constraint(equalToConstant: self.view.frame.width - 2*margin).isActive = true
        type.centerYAnchor.constraint(equalTo: typeLabel.centerYAnchor).isActive = true
        type.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.028).isActive = true
        
        
        
        //date.font = UIFont.systemFont(ofSize: 13)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        date.text = dateFormatter.string(from: (appDelegate.selected_item?.updateAt)!)
        
        date.translatesAutoresizingMaskIntoConstraints = false
        date.textAlignment = .right
        date.rightAnchor.constraint(equalTo: (infoContainer?.rightAnchor)!, constant: -rightMargin).isActive = true
        date.widthAnchor.constraint(equalToConstant: self.view.frame.width - 2*margin).isActive = true
        date.topAnchor.constraint(equalTo: (infoContainer?.topAnchor)!, constant: UIScreen.main.bounds.height * 0.02).isActive = true
        date.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.024).isActive = true
        
        
        let description = UILabel()
        description.text = "Description"
        description.font = typeLabel.font
        infoContainer?.addSubview(description)
        description.translatesAutoresizingMaskIntoConstraints = false
        
        description.leftAnchor.constraint(equalTo: (infoContainer?.leftAnchor)!, constant: UIScreen.main.bounds.width*0.041).isActive = true
        description.widthAnchor.constraint(equalToConstant: self.view.frame.width - 2*margin).isActive = true
        description.topAnchor.constraint(equalTo: type.bottomAnchor, constant: UIScreen.main.bounds.height * 0.01).isActive = true
        description.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height*0.028).isActive = true
        
        let descriptionContent = UITextView()
        descriptionContent.isEditable = false
        descriptionContent.font = UIFont.systemFont(ofSize: description.font.pointSize - 2)
        descriptionContent.text = appDelegate.selected_item?.description
        descriptionContent.textContainerInset = UIEdgeInsets.zero
        descriptionContent.textContainer.lineFragmentPadding = 0
        infoContainer?.addSubview(descriptionContent)
        descriptionContent.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionContent.leftAnchor.constraint(equalTo: (infoContainer?.leftAnchor)!, constant: UIScreen.main.bounds.width*0.05).isActive = true
        descriptionContent.rightAnchor.constraint(equalTo: (infoContainer?.rightAnchor)!, constant: -UIScreen.main.bounds.width*0.05).isActive = true
        descriptionContent.topAnchor.constraint(equalTo: description.bottomAnchor, constant: UIScreen.main.bounds.height * 0.009).isActive = true
        let heightForDescritionContentConstraint = descriptionContent.heightAnchor.constraint(equalToConstant: 50)
        heightForDescritionContentConstraint.isActive = true
        
        
        
        
        self.view.layoutIfNeeded()
        
        name.font = UIFont(name: "Helvetica-CondensedBlack", size: 14)
        name.font = UIFont(name: "Helvetica-CondensedBlack", size: findIconLabelSize(height : name.frame.height, label : name, font : "Helvetica-CondensedBlack"))
        brand.font = UIFont(name: "Helvetica-CondensedBlack", size: 14)
        brand.font = UIFont(name: "Helvetica-CondensedBlack", size: findIconLabelSize(height : brand.frame.height, label : brand, font : "Helvetica-CondensedBlack"))
        date.font = UIFont.systemFont(ofSize: findIconLabelSize(height: date.frame.height, label: date))
        type.font = UIFont.systemFont(ofSize: findIconLabelSize(height: type.frame.height, label: type))
        
        
        heightForDescritionContentConstraint.constant = descriptionContent.contentSize.height
        infoHeightConstrait?.constant = descriptionContent.frame.origin.y + descriptionContent.contentSize.height        
        self.view.layoutIfNeeded()
    }
    
    func setupIngredientsContainer(){
        ingredientsContainer = UIView()
        ingredientsContainer?.backgroundColor = UIColor.white
        let margin : CGFloat = 5
        
        var content = ""
        let rightMargin : CGFloat = UIScreen.main.bounds.width * 0.032

        for i in 0..<((appDelegate.selected_item?.ingredients.count)! > 5 ? 5 : (appDelegate.selected_item?.ingredients.count)!) {
            if(content.characters.count == 0 ){
                content = (appDelegate.selected_item?.ingredients[i].name)!
            }else{
                content += ", \((appDelegate.selected_item?.ingredients[i].name)!)"
            }
        }
        
        viewContainer.addSubview(ingredientsContainer!)
        
        ingredientsContainer?.layoutIfNeeded()
        
        
        ingredientsContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsContainer?.topAnchor.constraint(equalTo: (infoContainer?.bottomAnchor)!, constant: 0).isActive = true
        ingredientsContainer?.centerXAnchor.constraint(equalTo: (infoContainer?.centerXAnchor)!, constant: 0).isActive = true
        ingredientsContainer?.widthAnchor.constraint(equalTo: (infoContainer?.widthAnchor)!, constant: 0).isActive = true
        
        let heightContainerConstraint = ingredientsContainer?.heightAnchor.constraint(equalToConstant: 50)
        heightContainerConstraint?.isActive = true
        
        let label = UILabel()
        label.text = "Primary Ingredients"
        ingredientsContainer?.addSubview(label)
        label.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: UIScreen.main.bounds.height*0.028, label: label))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: (ingredientsContainer?.topAnchor)!, constant: UIScreen.main.bounds.height * 0.01).isActive = true
        label.leftAnchor.constraint(equalTo: (ingredientsContainer?.leftAnchor)!, constant: UIScreen.main.bounds.width*0.041).isActive = true
        label.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.028).isActive = true
        label.widthAnchor.constraint(equalTo: (ingredientsContainer?.widthAnchor)!, multiplier: 1.0, constant: -2*margin).isActive = true
        
        let ingredients = UITextView()
        ingredients.isEditable = false

        ingredientsContainer?.addSubview(ingredients)
        ingredients.text = content
        
        ingredients.font = UIFont.systemFont(ofSize: label.font.pointSize - 2)
        ingredients.textContainerInset = UIEdgeInsets.zero
        ingredients.textContainer.lineFragmentPadding = 0
        
        ingredients.translatesAutoresizingMaskIntoConstraints = false
        
        ingredients.leftAnchor.constraint(equalTo: (ingredientsContainer?.leftAnchor)!, constant: UIScreen.main.bounds.width*0.05).isActive = true
        ingredients.rightAnchor.constraint(equalTo: (ingredientsContainer?.rightAnchor)!, constant: -UIScreen.main.bounds.width*0.05).isActive = true
        ingredients.topAnchor.constraint(equalTo: label.bottomAnchor, constant: UIScreen.main.bounds.height * 0.009).isActive = true
        let heightForIngredientsContentConstraint = ingredients.heightAnchor.constraint(equalToConstant: 50)
        heightForIngredientsContentConstraint.isActive = true
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("See All Ingredients", for: .normal)
        //button.titleLabel?.text = "See All Ingredients"
        button.semanticContentAttribute = .forceRightToLeft
        let origImage = UIImage(named: "forward_fit")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = myColor.labelButtonColor
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.textAlignment = .right
        button.contentHorizontalAlignment = .right
        let tmp = UILabel()
        tmp.text = "See All Ingredients"
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: UIScreen.main.bounds.height * 0.03, label: tmp))
        
        button.addTarget(self, action: #selector(onClickSeeAllIngredients(sender:)), for: .touchUpInside)
        
        ingredientsContainer?.addSubview(button)
        
        button.setTitleColor(myColor.labelButtonColor, for: .normal)
        
        button.topAnchor.constraint(equalTo: ingredients.bottomAnchor, constant: UIScreen.main.bounds.height * 0.01).isActive = true
        let buttonRightAnchor = button.rightAnchor.constraint(equalTo: (ingredientsContainer?.rightAnchor)!, constant: -rightMargin)
        buttonRightAnchor.isActive = true
        button.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03 + 6).isActive = true
        let buttonWidthConstraint = button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        buttonWidthConstraint.isActive = true
//        button.imageView?.backgroundColor = UIColor.red
//        button.titleLabel?.backgroundColor = UIColor.cyan
//        button.backgroundColor = UIColor.darkGray
        
        self.view.layoutIfNeeded()
//        print("image view : \(button.imageView?.frame)")
//        print("label view : \(button.titleLabel?.frame)")
//        print("width : \(widthOfText(font: (button.titleLabel?.font)!, text: (button.titleLabel?.text)!))")
        let scaleFactor = (button.imageView?.frame.height)! / 44  //44는 이미지 원래 세로길이
        
        //button.imageView?.frame = CGRect(x: 718, y: 0, width: 36.5, height: 36.5)
        //button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 13.5, bottom: 0, right: 0)
        buttonWidthConstraint.constant = (button.titleLabel?.frame.width)! + (button.imageView?.frame.width)!
        buttonRightAnchor.constant += ((button.imageView?.frame.width)! - (24 * scaleFactor)) * 0.5
        
        heightForIngredientsContentConstraint.constant = ingredients.contentSize.height
        heightContainerConstraint?.constant = button.frame.height + button.frame.origin.y
        
        self.view.layoutIfNeeded()
        
    }
    
    func setupGAContainer(){
        
        let margin : CGFloat = 5
        
        gAContainer = UIView()
        
        gAContainer?.backgroundColor = UIColor.white
        viewContainer.addSubview(gAContainer!)
        
        gAContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        let GALabel = UILabel()
        GALabel.text = "Guaranteed Analysis"
        GALabel.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: UIScreen.main.bounds.height*0.028, label: GALabel))
        GALabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        gAContainer?.addSubview(GALabel)
        
        GALabel.topAnchor.constraint(equalTo: (gAContainer?.topAnchor)!, constant: UIScreen.main.bounds.height * 0.01).isActive = true
        GALabel.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: UIScreen.main.bounds.width*0.041).isActive = true
        GALabel.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.028).isActive = true
        GALabel.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!, multiplier: 1.0, constant: -2*margin).isActive = true
        
        let leftMargin = UIScreen.main.bounds.width*0.05
        let bigMargin = UIScreen.main.bounds.height * 0.022
        let smallMargin = UIScreen.main.bounds.height * 0.011
        let tmpLabel = UILabel()
        tmpLabel.text = "Test"
        let textHeight = UIScreen.main.bounds.height * 0.024
        let font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: textHeight, label: tmpLabel))
        
        let protein = UILabel()
        protein.text = "Crude Protein"
        protein.font = font
        
        protein.translatesAutoresizingMaskIntoConstraints = false

        
        gAContainer?.addSubview(protein)
        
        protein.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        protein.topAnchor.constraint(equalTo: GALabel.bottomAnchor, constant: bigMargin).isActive = true
        protein.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!, constant: -2*margin).isActive = true
        protein.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let proteinGage = GA_Gage()
        
        let filteredCrude = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "crude") != nil {

                return true
            }
            return false
        })
        
        let proteinValue = filteredCrude?.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "protein") != nil {
                return true
            }
            return false
        })
        
        if (proteinValue?.count)! > 0 {
            let divideValue = proteinValue?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            proteinGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            proteinGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        //proteinGage.setup(_fullValue: 100, _value: <#T##CGFloat#>, _back_gageColor: <#T##UIColor#>, _gageColor: <#T##UIColor#>)
        proteinGage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(proteinGage)
        
        let proteinLabel = UILabel()
        proteinLabel.translatesAutoresizingMaskIntoConstraints = false
        proteinLabel.text = "\((proteinValue?[0].content)!) (\((proteinValue?[0].Max)! ? "Max":"Min"))"
        proteinLabel.font = font
        proteinLabel.textAlignment = .right
        
        
        let testLabel = UILabel(frame : CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: textHeight))
        testLabel.text = "00.0% (Min)"
        testLabel.font = font
        testLabel.sizeToFit()
        testLabel.layoutIfNeeded()
        
        let per_width = testLabel.frame.width
        
        let gage_width = (UIScreen.main.bounds.width - 2 * leftMargin) - per_width - 0.001 * (UIScreen.main.bounds.width - 2 * leftMargin)
        
        gAContainer?.addSubview(proteinLabel)
        proteinLabel.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -leftMargin).isActive = true
        proteinLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        proteinLabel.topAnchor.constraint(equalTo: protein.bottomAnchor, constant: smallMargin).isActive = true
        proteinLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        proteinGage.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        proteinGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        proteinGage.centerYAnchor.constraint(equalTo: proteinLabel.centerYAnchor).isActive = true
        proteinGage.heightAnchor.constraint(equalTo: proteinLabel.heightAnchor, multiplier: 0.8).isActive = true
        ////////////////
        let height3 : CGFloat = 20
        ///////////Crude Fat
        let fat = UILabel()
        fat.text = "Crude Fat"
        fat.font = font
        
        fat.translatesAutoresizingMaskIntoConstraints = false
        

        
        gAContainer?.addSubview(fat)
        
        fat.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        fat.topAnchor.constraint(equalTo: proteinLabel.bottomAnchor, constant: smallMargin).isActive = true
        fat.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!, constant: -2*margin).isActive = true
        fat.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        var fatValue = filteredCrude?.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "fat") != nil {
                return true
            }
            return false
        })
        
        if fatValue?.count  == 0{
            let fatFiltered = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
                if data.name.lowercased().range(of: "fat") != nil {
                    return true
                }
                return false
            })
            
            fatValue = fatFiltered?.filter({ (data) -> Bool in
                if data.name.lowercased().range(of: "content") != nil {
                    return true
                }
                return false
            })
            
            if (fatValue?.count)! > 0 {
                fat.text = "Fat Content"
            }
        }
        
        let fatLabel = UILabel()
        fatLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fatLabel.text = (fatValue?.count)! > 0 ? "\((fatValue?[0].content)!) (\((fatValue?[0].Max)! ? "Max":"Min"))" : "0%"
        fatLabel.font = font
        fatLabel.textAlignment = .right

        gAContainer?.addSubview(fatLabel)
        fatLabel.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -leftMargin).isActive = true
        fatLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        fatLabel.topAnchor.constraint(equalTo: fat.bottomAnchor, constant: smallMargin).isActive = true
        fatLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let fatGage = GA_Gage()
        
        if (fatValue?.count)! > 0 {
            let divideValue = fatValue?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            fatGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            fatGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        

        fatGage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(fatGage)
        
        fatGage.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        fatGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        fatGage.centerYAnchor.constraint(equalTo: fatLabel.centerYAnchor).isActive = true
        fatGage.heightAnchor.constraint(equalTo: fatLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        //////Crude Fibres
        let fibres = UILabel()
        fibres.text = "Crude Fibres"
        fibres.font = font
        
        fibres.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        gAContainer?.addSubview(fibres)
        
        fibres.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        fibres.topAnchor.constraint(equalTo: fatLabel.bottomAnchor, constant: smallMargin).isActive = true
        fibres.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!, constant: -2*margin).isActive = true
        fibres.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let fibresValue = filteredCrude?.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "fibre") != nil {
                return true
            }
            return false
        })
        
        let fibresLabel = UILabel()
        fibresLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fibresLabel.text = (fibresValue?.count)! > 0 ? "\((fibresValue?[0].content)!) (\((fibresValue?[0].Max)! ? "Max":"Min"))" : "0%"
        fibresLabel.font = font
        fibresLabel.textAlignment = .right
        
        
        gAContainer?.addSubview(fibresLabel)
        fibresLabel.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -leftMargin).isActive = true
        fibresLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        fibresLabel.topAnchor.constraint(equalTo: fibres.bottomAnchor, constant: smallMargin).isActive = true
        fibresLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let fibresGage = GA_Gage()
        
        if (fibresValue?.count)! > 0 {
            let divideValue = fibresValue?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            fibresGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            fibresGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        
        fibresGage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(fibresGage)
        
        fibresGage.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        fibresGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        fibresGage.centerYAnchor.constraint(equalTo: fibresLabel.centerYAnchor).isActive = true
        fibresGage.heightAnchor.constraint(equalTo: fibresLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        //// Crude Ash
        let ash = UILabel()
        ash.text = "Crude Ash"
        ash.font = font
        
        ash.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        gAContainer?.addSubview(ash)
        
        ash.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        ash.topAnchor.constraint(equalTo: fibresLabel.bottomAnchor, constant: smallMargin).isActive = true
        ash.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!, constant: -2*margin).isActive = true
        ash.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let ashValue = filteredCrude?.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "ash") != nil {
                return true
            }
            return false
        })
        
        let ashLabel = UILabel()
        ashLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ashLabel.text = (ashValue?.count)! > 0 ? "\((ashValue?[0].content)!) (\((ashValue?[0].Max)! ? "Max":"Min"))" : "0%"
        ashLabel.font = font
        ashLabel.textAlignment = .right
        
        
        
        gAContainer?.addSubview(ashLabel)
        ashLabel.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -leftMargin).isActive = true
        ashLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        ashLabel.topAnchor.constraint(equalTo: ash.bottomAnchor, constant: smallMargin).isActive = true
        ashLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let ashGage = GA_Gage()
        
        if (ashValue?.count)! > 0 {
            let divideValue = ashValue?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            ashGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            ashGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        
        ashGage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(ashGage)
        
        ashGage.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        ashGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        ashGage.centerYAnchor.constraint(equalTo: ashLabel.centerYAnchor).isActive = true
        ashGage.heightAnchor.constraint(equalTo: ashLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        ///////Moisture
        let moisture = UILabel()
        moisture.text = "Moisture"
        moisture.font = font
        
        moisture.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        gAContainer?.addSubview(moisture)
        
        moisture.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        moisture.topAnchor.constraint(equalTo: ashLabel.bottomAnchor, constant: smallMargin).isActive = true
        moisture.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!, constant: -2*margin).isActive = true
        moisture.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let moistureValue = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "moisture") != nil {

                return true
            }
            return false
        })
        
        let moistureLabel = UILabel()
        moistureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        moistureLabel.text = (moistureValue?.count)! > 0 ? "\((moistureValue?[0].content)!) (\((moistureValue?[0].Max)! ? "Max":"Min"))" : "0%"
        moistureLabel.font = font
        moistureLabel.textAlignment = .right
        
        
        
        gAContainer?.addSubview(moistureLabel)
        moistureLabel.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -leftMargin).isActive = true
        moistureLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        moistureLabel.topAnchor.constraint(equalTo: moisture.bottomAnchor, constant: smallMargin).isActive = true
        moistureLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let moistureGage = GA_Gage()
        
        if (moistureValue?.count)! > 0 {
            let divideValue = moistureValue?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            moistureGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            moistureGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        
        moistureGage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(moistureGage)
        
        moistureGage.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        moistureGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        moistureGage.centerYAnchor.constraint(equalTo: moistureLabel.centerYAnchor).isActive = true
        moistureGage.heightAnchor.constraint(equalTo: moistureLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        ///////////////Calcium
        
        let calcium = UILabel()
        
        let midMargin = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? leftMargin * 0.5 : leftMargin * 0.25
        
        calcium.text = "Calcium"
        calcium.font = font
        
        calcium.translatesAutoresizingMaskIntoConstraints = false
        

        
        gAContainer?.addSubview(calcium)
        
        calcium.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        calcium.topAnchor.constraint(equalTo: moistureLabel.bottomAnchor, constant: bigMargin).isActive = true
        calcium.rightAnchor.constraint(equalTo: (gAContainer?.centerXAnchor)!).isActive = true
        calcium.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let calciumValue = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "calcium") != nil {

                return true
            }
            return false
        })
        
        let calciumLabel = UILabel()
        calciumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        calciumLabel.text = (calciumValue?.count)! > 0 ? "\((calciumValue?[0].content)!) (\((calciumValue?[0].Max)! ? "Max":"Min"))" : "0%"
        calciumLabel.font = font
        calciumLabel.textAlignment = .right
        
        
        gAContainer?.addSubview(calciumLabel)
        calciumLabel.rightAnchor.constraint(equalTo: (gAContainer?.centerXAnchor)!, constant: -midMargin).isActive = true
        calciumLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        calciumLabel.topAnchor.constraint(equalTo: calcium.bottomAnchor, constant: smallMargin).isActive = true
        calciumLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let calciumGage = GA_Gage()
        
        if (calciumValue?.count)! > 0 {
            let divideValue = calciumValue?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            calciumGage.setup(_fullValue: 10, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
            
            
        }else {
            calciumGage.setup(_fullValue: 10, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
        }
        let subgage_width = 0.99 * (UIScreen.main.bounds.width * 0.5 - midMargin - leftMargin - per_width)
        
        calciumGage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(calciumGage)
        
        calciumGage.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        calciumGage.widthAnchor.constraint(equalToConstant: subgage_width).isActive = true
        calciumGage.centerYAnchor.constraint(equalTo: calciumLabel.centerYAnchor).isActive = true
        calciumGage.heightAnchor.constraint(equalTo: calciumLabel.heightAnchor, multiplier: 0.9).isActive = true
        
        ///////////phosphorous
        let phosphorous = UILabel()
        
        phosphorous.text = "Phosphorous"
        phosphorous.font = font
        
        phosphorous.translatesAutoresizingMaskIntoConstraints = false
        
        gAContainer?.addSubview(phosphorous)
        
        phosphorous.leftAnchor.constraint(equalTo: (gAContainer?.centerXAnchor)!, constant: midMargin).isActive = true
        phosphorous.topAnchor.constraint(equalTo: moistureLabel.bottomAnchor, constant: bigMargin).isActive = true
        phosphorous.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!,multiplier: 0.5 ,constant: -2*margin).isActive = true
        phosphorous.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let phosphorousValue = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "phosphorous") != nil {

                return true
            }
            return false
        })
        
        let phosphorousLabel = UILabel()
        phosphorousLabel.translatesAutoresizingMaskIntoConstraints = false
        
        phosphorousLabel.text = (phosphorousValue?.count)! > 0 ? "\((phosphorousValue?[0].content)!) (\((phosphorousValue?[0].Max)! ? "Max":"Min"))" : "0%"
        phosphorousLabel.font = font
        phosphorousLabel.textAlignment = .right
        
        
        gAContainer?.addSubview(phosphorousLabel)
        phosphorousLabel.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -leftMargin).isActive = true
        phosphorousLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        phosphorousLabel.topAnchor.constraint(equalTo: phosphorous.bottomAnchor, constant: smallMargin).isActive = true
        phosphorousLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let phosphorousGage = GA_Gage()
        
        if (phosphorousValue?.count)! > 0 {
            let divideValue = phosphorousValue?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            phosphorousGage.setup(_fullValue: 10, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
            
            
        }else {
            phosphorousGage.setup(_fullValue: 10, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
        }
        
        
        phosphorousGage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(phosphorousGage)
        
        phosphorousGage.leftAnchor.constraint(equalTo: (gAContainer?.centerXAnchor)!, constant: midMargin).isActive = true
        phosphorousGage.widthAnchor.constraint(equalToConstant: subgage_width).isActive = true
        phosphorousGage.centerYAnchor.constraint(equalTo: phosphorousLabel.centerYAnchor).isActive = true
        phosphorousGage.heightAnchor.constraint(equalTo: phosphorousLabel.heightAnchor, multiplier: 0.8).isActive = true
        ///// Omega
        let filteredOmega = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "omega") != nil {

                return true
            }
            return false
        })
        
        
        ///////Omega 3
        let omega3 = UILabel()
        
        omega3.text = "Omega-3 Fatty Acids"
        omega3.font = font
        
        omega3.translatesAutoresizingMaskIntoConstraints = false
        
        
        gAContainer?.addSubview(omega3)
        
        omega3.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        omega3.topAnchor.constraint(equalTo: calciumLabel.bottomAnchor, constant: smallMargin * 1.6).isActive = true
        omega3.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!,multiplier: 0.5 ,constant: -2*margin).isActive = true
        omega3.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let omega3Value = filteredOmega?.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "3") != nil {

                return true
            }
            return false
        })
        
        let omega3Label = UILabel()
        omega3Label.translatesAutoresizingMaskIntoConstraints = false
        
        omega3Label.text = (omega3Value?.count)! > 0 ? "\((omega3Value?[0].content)!) (\((omega3Value?[0].Max)! ? "Max":"Min"))" : "0%"
        omega3Label.font = font
        omega3Label.textAlignment = .right
        
        
        gAContainer?.addSubview(omega3Label)
        omega3Label.rightAnchor.constraint(equalTo: (gAContainer?.centerXAnchor)!, constant: -midMargin).isActive = true
        omega3Label.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        omega3Label.topAnchor.constraint(equalTo: omega3.bottomAnchor, constant: smallMargin).isActive = true
        omega3Label.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let omega3Gage = GA_Gage()
        
        if (omega3Value?.count)! > 0 {
            let divideValue = omega3Value?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            omega3Gage.setup(_fullValue: 10, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
            
            
        }else {
            omega3Gage.setup(_fullValue: 10, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
        }
        
        
        omega3Gage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(omega3Gage)
        
        omega3Gage.leftAnchor.constraint(equalTo: (gAContainer?.leftAnchor)!, constant: leftMargin).isActive = true
        omega3Gage.widthAnchor.constraint(equalToConstant: subgage_width).isActive = true
        omega3Gage.centerYAnchor.constraint(equalTo: omega3Label.centerYAnchor).isActive = true
        omega3Gage.heightAnchor.constraint(equalTo: omega3Label.heightAnchor, multiplier: 0.8).isActive = true
        
        ///////////phosphorous
        let omega6 = UILabel()
        
        omega6.text = "Omega-6 Fatty Acids"
        omega6.font = font
        
        omega6.translatesAutoresizingMaskIntoConstraints = false
        
        gAContainer?.addSubview(omega6)
        
        omega6.leftAnchor.constraint(equalTo: (gAContainer?.centerXAnchor)!, constant: midMargin).isActive = true
        omega6.topAnchor.constraint(equalTo: calciumLabel.bottomAnchor, constant: smallMargin * 1.6).isActive = true
        omega6.widthAnchor.constraint(equalTo: (gAContainer?.widthAnchor)!,multiplier: 0.5 ,constant: -2*margin).isActive = true
        omega6.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let omega6Value = filteredOmega?.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "6") != nil {

                return true
            }
            return false
        })
        
        let omega6Label = UILabel()
        omega6Label.translatesAutoresizingMaskIntoConstraints = false
        
        omega6Label.text = (omega6Value?.count)! > 0 ? "\((omega6Value?[0].content)!) (\((omega6Value?[0].Max)! ? "Max":"Min"))" : "0%"
        omega6Label.font = font
        omega6Label.textAlignment = .right
        
        
        gAContainer?.addSubview(omega6Label)
        omega6Label.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -leftMargin).isActive = true
        omega6Label.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        omega6Label.topAnchor.constraint(equalTo: omega6.bottomAnchor, constant: smallMargin).isActive = true
        omega6Label.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let omega6Gage = GA_Gage()
        
        if (omega6Value?.count)! > 0 {
            let divideValue = omega6Value?[0].content.components(separatedBy: "%")
            
            let value = ((divideValue?[0])! as NSString).floatValue
            
            omega6Gage.setup(_fullValue: 10, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
            
            
        }else {
            omega6Gage.setup(_fullValue: 10, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
        }
        
        
        omega6Gage.translatesAutoresizingMaskIntoConstraints = false
        gAContainer?.addSubview(omega6Gage)
        
        omega6Gage.leftAnchor.constraint(equalTo: (gAContainer?.centerXAnchor)!, constant: midMargin).isActive = true
        omega6Gage.widthAnchor.constraint(equalToConstant: subgage_width).isActive = true
        omega6Gage.centerYAnchor.constraint(equalTo: omega6Label.centerYAnchor).isActive = true
        omega6Gage.heightAnchor.constraint(equalTo: omega6Label.heightAnchor, multiplier: 0.8).isActive = true
        //////////See Detail Button
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("See Details", for: .normal)
        button.setTitleColor(myColor.labelButtonColor, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        let origImage = UIImage(named: "forward_fit")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = myColor.labelButtonColor
        button.contentMode = .scaleAspectFit
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.textAlignment = .right
        button.contentHorizontalAlignment = .right
        let tmp = UILabel()
        tmp.text = "See Details"
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: UIScreen.main.bounds.height * 0.03, label: tmp))
        
        button.addTarget(self, action: #selector(onClickSeeDetails(sender:)), for: .touchUpInside)
        
        gAContainer?.addSubview(button)
        button.setTitleColor(myColor.labelButtonColor, for: .normal)

        
        button.topAnchor.constraint(equalTo: omega3Label.bottomAnchor, constant: bigMargin * 1.3).isActive = true
        let buttonRightAnchor = button.rightAnchor.constraint(equalTo: (gAContainer?.rightAnchor)!, constant: -(UIScreen.main.bounds.width * 0.032))
        buttonRightAnchor.isActive = true
        button.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.03 + 6).isActive = true
        let buttonWidthConstraint = button.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        buttonWidthConstraint.isActive = true
        

        
        
        //////////////// Container
        
        gAContainer?.topAnchor.constraint(equalTo: (ingredientsContainer?.bottomAnchor)!).isActive = true
        gAContainer?.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        gAContainer?.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        let containerHeightConstraint = gAContainer?.heightAnchor.constraint(equalToConstant: 50)
        containerHeightConstraint?.isActive = true
        
        self.view.layoutIfNeeded()
        
        let scaleFactor = (button.imageView?.frame.height)! / 44  //44는 이미지 원래 세로길이
        
        buttonWidthConstraint.constant = (button.titleLabel?.frame.width)! + (button.imageView?.frame.width)!
        buttonRightAnchor.constant += ((button.imageView?.frame.width)! - (24 * scaleFactor)) * 0.5
        containerHeightConstraint?.constant = button.frame.origin.y + button.frame.height + bigMargin * 2.5
        
        self.view.layoutIfNeeded()
    }
    func onClickSeeDetails(sender: UIButton){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        
        let guaranteedAnalysisVC = storyBoard.instantiateViewController(withIdentifier: "GuaranteedAnalysisVC") as! GuaranteedAnalysisVC
        
        self.navigationController?.pushViewController(guaranteedAnalysisVC, animated: true)
    }
    
    func onClickSeeAllIngredients(sender: UIButton) {

        
//        for ingredient in (appDelegate.selected_item?.ingredients)!
//        {
//            
//            print(ingredient.name)
//            print("/////////")
//        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        
        let ingredientsVC = storyBoard.instantiateViewController(withIdentifier: "IngredientsVC") as! IngredientsVC
        
        self.navigationController?.pushViewController(ingredientsVC, animated: true)
        
    }
    func makeBarButton(size : CGSize, icon : String, text : String, action: Selector) -> UIBarButtonItem
    {

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: size.width/4, height: size.height))
        button.setImage(UIImage(named: icon), for: .normal)
        
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        let barbutton = UIBarButtonItem(customView: button)
        barbutton.width = size.width/4
        
        return barbutton
    }
    
    func onClickModify(sender: UIBarButtonItem) {

    }
    func setupHomeButon(){
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(clickedHome(sender:)))
    }
    func clickedHome(sender : UIBarButtonItem){
        
        let nextViewController = self.navigationController?.viewControllers[0] as! ViewController
        self.navigationController?.popToViewController(nextViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



