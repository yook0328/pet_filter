//
//  MenuButton01VC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 17..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class MenuButton01VC: UIViewController {

    var logo = UIImageView()
    var qLabel = UIImageView()
    var foodBtn = UIButton()
    var treatsBtn = UIButton()
    
    var category : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        category = [String]()
        category?.append("사료")
        category?.append("간식")
        
//        let backButton = UIBarButtonItem(title: "< Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
//        navigationItem.leftBarButtonItem = backButton
        
//        let backButton = UIButton(type: .custom)
//        backButton.frame.size = CGSize(width: 40, height: 40)
//        backButton.setImage(UIImage(named: "Back"), for: .normal)
//        backButton.setTitle("Back", for: .normal)
//        backButton.setTitleColor(UIColor.blue, for: .normal)
//        backButton.addTarget(self, action: #selector(self.back(sender:)), for: .touchUpInside)
//        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        

        let label = UILabel()
        label.text = "(C) 2017 by The Six & Kensington Pet Food Plus."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        self.view.addSubview(label)
        
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -UIScreen.main.bounds.height * 0.026).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.025).isActive = true
        
        label.font = UIFont.systemFont(ofSize: findIconLabelSize(height: UIScreen.main.bounds.height * 0.025, label: label))
        label.textColor = myColor.mainColor
        
        setupLabel()
        setupBtn()
        setupHomeButon()
        setupNavigation()
        
    }
    
//    func back(){
//        
//        let transition = CATransition()
//        transition.duration = 0.2
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromLeft
//        view.window!.layer.add(transition, forKey: kCATransition)
//        
//        dismiss(animated: false, completion: nil)
//    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    func setupNavigation(){
        //let height: CGFloat = 50 //whatever height you want
        let frame = self.navigationController!.navigationBar.frame
        print(self.navigationController!.navigationBar.frame)
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: frame.origin.y, width: frame.width, height: UIScreen.main.bounds.height*0.08)


        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupLabel(){
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(logo)
        logo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: height*0.16).isActive = true
        logo.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.68).isActive = true
        logo.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.12).isActive = true
        
        logo.image = UIImage(named: "logo_label")
        logo.contentMode = .scaleAspectFit
        
        qLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(qLabel)
        qLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        qLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        qLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.51).isActive = true
        qLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.069).isActive = true
        
        qLabel.image = UIImage(named: "choose_label")
        qLabel.contentMode = .scaleAspectFit
    }
    func setupBtn(){
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        foodBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(foodBtn)
        
        foodBtn.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -width*0.038).isActive = true
        foodBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: height*0.65).isActive = true
        foodBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.32).isActive    = true
        foodBtn.heightAnchor.constraint(equalTo: foodBtn.widthAnchor, multiplier: 0.78).isActive = true
        
        foodBtn.layer.borderColor = myColor.mainColor.cgColor
        foodBtn.layer.borderWidth = 1.5
        foodBtn.layer.cornerRadius = 10
        foodBtn.tag = 0
        let foodImage = UIImageView()
        foodBtn.addSubview(foodImage)
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        foodImage.centerXAnchor.constraint(equalTo: foodBtn.centerXAnchor).isActive = true
        foodImage.centerYAnchor.constraint(equalTo: foodBtn.centerYAnchor).isActive = true
        foodImage.widthAnchor.constraint(equalTo: foodBtn.widthAnchor, multiplier: 0.54).isActive = true
        foodImage.heightAnchor.constraint(equalTo: foodBtn.heightAnchor, multiplier: 0.56).isActive = true
        foodImage.image = UIImage(named: "food_btn")
        foodImage.contentMode = .scaleAspectFit
        
        foodBtn.addTarget(self, action: #selector(self.clickedBtn(sender:)), for: .touchUpInside)
        
        treatsBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(treatsBtn)
        
        treatsBtn.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: width*0.038).isActive = true
        treatsBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: height*0.65).isActive = true
        treatsBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.32).isActive    = true
        treatsBtn.heightAnchor.constraint(equalTo: treatsBtn.widthAnchor, multiplier: 0.78).isActive = true
        
        treatsBtn.layer.borderColor = myColor.mainColor.cgColor
        treatsBtn.layer.borderWidth = 1.5
        treatsBtn.layer.cornerRadius = 10
        treatsBtn.tag = 1
        let treatsImage = UIImageView()
        treatsBtn.addSubview(treatsImage)
        treatsImage.translatesAutoresizingMaskIntoConstraints = false
        treatsImage.centerXAnchor.constraint(equalTo: treatsBtn.centerXAnchor).isActive = true
        treatsImage.centerYAnchor.constraint(equalTo: treatsBtn.centerYAnchor).isActive = true
        treatsImage.widthAnchor.constraint(equalTo: treatsBtn.widthAnchor, multiplier: 0.54).isActive = true
        treatsImage.heightAnchor.constraint(equalTo: treatsBtn.heightAnchor, multiplier: 0.56).isActive = true
        treatsImage.image = UIImage(named: "treats_btn" )
        treatsImage.contentMode = .scaleAspectFit
        
        treatsBtn.addTarget(self, action: #selector(self.clickedBtn(sender:)), for: .touchUpInside)
    }
    func clickedBtn(sender : UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(sender.tag)
        appDelegate.before_item_list_filter.item_type = sender.tag
        self.navigationController?.isNavigationBarHidden = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FilterVC")
        self.navigationController?.pushViewController(nextViewController, animated: true)
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
    
}

extension MenuButton01VC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //self.performSegue(withIdentifier: "MenuButton01Nav", sender: nil)
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MenuButton02")
//        self.navigationController?.pushViewController(nextViewController, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.before_item_list_filter.item_type = indexPath.row
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        
        let menuButton04VC = storyBoard.instantiateViewController(withIdentifier: "MenuButton04") as! MenuButton04VC
        
        self.navigationController?.pushViewController(menuButton04VC, animated: true)
    }
}

extension MenuButton01VC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (category?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIButtonCollectionViewCell", for: indexPath as IndexPath) as! UIButtonCollectionViewCell
        cell.setText(_text: (category?[indexPath.row])!)
        switch indexPath.row {
        case 0:
            cell.backgroundColor = myColor.color01
            break
        case 1:
            cell.backgroundColor = myColor.color02
            break
        case 2:
            cell.backgroundColor = myColor.color03
            break
        case 3:
            cell.backgroundColor = myColor.color04
            break
        default: break
            
        }
        return cell
    }
    
    
}
