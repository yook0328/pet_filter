//
//  MenuButton03VC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 18..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class MenuButton03VC: UIViewController {
    @IBOutlet weak var buttonContainer: UICollectionView!

    @IBOutlet weak var qLabel: UILabel!
    var category : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        category = [String]()
        category?.append("사료")
        category?.append("간식")
        category?.append("치아")
        category?.append("건강")
        category?.append("배변/위생")
        category?.append("미용")
        category?.append("급수/식수기")
        category?.append("하우스/울타리")
        category?.append("이동장")
        category?.append("의류/악세서리")
        category?.append("장난감")
        
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.height)! - UIApplication.shared.statusBarFrame.height
        
        buttonContainer.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height, width: width, height: height)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: buttonContainer.frame.width/2, height: buttonContainer.frame.width/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        buttonContainer!.collectionViewLayout = layout
        buttonContainer.backgroundColor = UIColor.gray
        
        
        //collectionView 안에 쓸데 없이 있는 위에 여백 제거.
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension MenuButton03VC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //self.performSegue(withIdentifier: "MenuButton01Nav", sender: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    
        let menuButton04VC = storyBoard.instantiateViewController(withIdentifier: "MenuButton04") as! MenuButton04VC

        self.navigationController?.pushViewController(menuButton04VC, animated: true)
    }
}

extension MenuButton03VC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (category?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UIButtonCollectionViewCell", for: indexPath as IndexPath) as! UIButtonCollectionViewCell
        cell.setText(_text: (category?[indexPath.row])!)
        cell.iconLabel.font = UIFont.systemFont(ofSize: 11)
        switch indexPath.row%8 {
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
        case 4:
            cell.backgroundColor = myColor.color05
            break
        case 5:
            cell.backgroundColor = myColor.color06
            break
        case 6:
            cell.backgroundColor = myColor.color07
            break
        case 7:
            cell.backgroundColor = myColor.color08
            break
        default: break
            
        }
        return cell
    }
    
    
}
