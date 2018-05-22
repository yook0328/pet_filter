//
//  ViewController.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 17..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var logo = UIImageView()
    var qLabel = UIImageView()
    var dogBtn = UIButton()
    var catBtn = UIButton()


    var category : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        category = [String]()
        category?.append("강아지")
        category?.append("고양이")

        self.navigationController?.isNavigationBarHidden = true
        
        setupLabel()
        setupBtn()
        
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
        //collectionView 안에 쓸데 없이 있는 위에 여백 제거.
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        

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
        dogBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dogBtn)
        
        dogBtn.rightAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -width*0.038).isActive = true
        dogBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: height*0.65).isActive = true
        dogBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.32).isActive    = true
        dogBtn.heightAnchor.constraint(equalTo: dogBtn.widthAnchor, multiplier: 0.78).isActive = true
        
        dogBtn.layer.borderColor = myColor.mainColor.cgColor
        dogBtn.layer.borderWidth = 1.5
        dogBtn.layer.cornerRadius = 10
        dogBtn.tag = 0
        let dogImage = UIImageView()
        dogBtn.addSubview(dogImage)
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        dogImage.centerXAnchor.constraint(equalTo: dogBtn.centerXAnchor).isActive = true
        dogImage.centerYAnchor.constraint(equalTo: dogBtn.centerYAnchor).isActive = true
        dogImage.widthAnchor.constraint(equalTo: dogBtn.widthAnchor, multiplier: 0.54).isActive = true
        dogImage.heightAnchor.constraint(equalTo: dogBtn.heightAnchor, multiplier: 0.56).isActive = true
        dogImage.image = UIImage(named: "dog_btn")
        dogImage.contentMode = .scaleAspectFit
        
        dogBtn.addTarget(self, action: #selector(self.clickedBtn(sender:)), for: .touchUpInside)
        
        catBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(catBtn)
        
        catBtn.leftAnchor.constraint(equalTo: self.view.centerXAnchor, constant: width*0.038).isActive = true
        catBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: height*0.65).isActive = true
        catBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.32).isActive    = true
        catBtn.heightAnchor.constraint(equalTo: catBtn.widthAnchor, multiplier: 0.78).isActive = true
        
        catBtn.layer.borderColor = myColor.mainColor.cgColor
        catBtn.layer.borderWidth = 1.5
        catBtn.layer.cornerRadius = 10
        catBtn.tag = 1
        let catImage = UIImageView()
        catBtn.addSubview(catImage)
        catImage.translatesAutoresizingMaskIntoConstraints = false
        catImage.centerXAnchor.constraint(equalTo: catBtn.centerXAnchor).isActive = true
        catImage.centerYAnchor.constraint(equalTo: catBtn.centerYAnchor).isActive = true
        catImage.widthAnchor.constraint(equalTo: catBtn.widthAnchor, multiplier: 0.54).isActive = true
        catImage.heightAnchor.constraint(equalTo: catBtn.heightAnchor, multiplier: 0.56).isActive = true
        catImage.image = UIImage(named: "cat_btn")
        catImage.contentMode = .scaleAspectFit
        
        catBtn.addTarget(self, action: #selector(self.clickedBtn(sender:)), for: .touchUpInside)
    }
    func clickedBtn(sender : UIButton){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        print(sender.tag)
        appDelegate.before_item_list_filter.pet_type = sender.tag
        self.navigationController?.isNavigationBarHidden = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MenuButton01")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //self.performSegue(withIdentifier: "MenuButton01Nav", sender: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        
        appDelegate.before_item_list_filter.pet_type = indexPath.row
        self.navigationController?.isNavigationBarHidden = false
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MenuButton01")
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
//        let transition = CATransition()
//        transition.duration = 0.2
//        transition.type = kCATransitionPush
//        transition.subtype = kCATransitionFromRight
//        view.window!.layer.add(transition, forKey: kCATransition)
//        
//        let navController = UINavigationController(rootViewController: nextViewController)
//        self.present(navController, animated: false, completion: nil)
        
//        let spinner:SpinningView = SpinningView(frame: CGRect(x:60, y: 100, width: 120, height: 120));
//        self.view.addSubview(spinner);
//        spinner.animate();
    }
}

extension ViewController : UICollectionViewDataSource {
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





