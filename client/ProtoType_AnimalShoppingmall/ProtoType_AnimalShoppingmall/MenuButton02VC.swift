//
//  MenuButton02VC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 17..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class MenuButton02VC: UIViewController {
    @IBOutlet weak var buttonContainer: UICollectionView!
    
    @IBOutlet weak var qLabel: UILabel!
    var category : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        category = [String]()
        category?.append("All")
        category?.append("소형견")
        category?.append("중형견")
        category?.append("대형견")
        
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.height)! - UIApplication.shared.statusBarFrame.height
        
        
        qLabel.frame = CGRect(x: (width-qLabel.frame.width)/2, y: height*0.25, width: qLabel.frame.width, height: qLabel.frame.height)
        
        
        buttonContainer.frame = CGRect(x: (width*0.2)/2, y: height*0.5, width: width*0.8, height: width*0.8)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: buttonContainer.frame.width/2, height: buttonContainer.frame.height/2)
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

extension MenuButton02VC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //self.performSegue(withIdentifier: "MenuButton01Nav", sender: nil)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MenuButton03")
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension MenuButton02VC : UICollectionViewDataSource {
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
