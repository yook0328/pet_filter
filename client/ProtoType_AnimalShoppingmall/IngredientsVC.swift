//
//  IngredientsVC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 4. 29..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class IngredientsVC: UIViewController {
    @IBOutlet weak var mainLabelContainer: UIView!
    var mainLabel: UILabel?
    @IBOutlet weak var ingredientsTable: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let cellId = "cellId"
    let cellHeight = UIScreen.main.bounds.height * 0.05

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsTable.register(IngredientCell.self, forCellReuseIdentifier: cellId)
        
        // Do any additional setup after loading the view.
        setupConstraint()
        
        setupHomeButon()
        
        print("////// Count : \(appDelegate.selected_item?.ingredients.count)")
        for data in (appDelegate.selected_item?.ingredients)!{
            print(data.name)
        }
    }
    
    func setupConstraint(){
        

        let topConst = (self.navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height
        let height = UIScreen.main.bounds.height * 0.087
        
        mainLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabelContainer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: topConst).isActive = true
        mainLabelContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        mainLabelContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        mainLabelContainer.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        mainLabel = UILabel()
        mainLabelContainer.addSubview(mainLabel!)
        mainLabelContainer.backgroundColor = UIColor.white
        mainLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel?.text = "Ingredients"
        mainLabel?.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: height*0.6, label: mainLabel!))
        mainLabel?.textAlignment = .center
        mainLabel?.centerYAnchor.constraint(equalTo: mainLabelContainer.centerYAnchor).isActive = true
        mainLabel?.centerXAnchor.constraint(equalTo: mainLabelContainer.centerXAnchor).isActive = true
        mainLabel?.widthAnchor.constraint(equalTo: mainLabelContainer.widthAnchor).isActive = true
        mainLabel?.heightAnchor.constraint(equalTo: mainLabelContainer.heightAnchor).isActive = true
        
        
        mainLabel?.textColor = UIColor.black
        
        let line = UIView()
        line.backgroundColor = UIColor.gray
        line.translatesAutoresizingMaskIntoConstraints = false
        mainLabelContainer?.addSubview(line)
        line.centerXAnchor.constraint(equalTo: mainLabelContainer.centerXAnchor).isActive = true
        line.centerYAnchor.constraint(equalTo: mainLabelContainer.bottomAnchor).isActive = true
        line.widthAnchor.constraint(equalTo: mainLabelContainer.widthAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        ingredientsTable.translatesAutoresizingMaskIntoConstraints = false
        
        ingredientsTable.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        ingredientsTable.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        ingredientsTable.topAnchor.constraint(equalTo: mainLabelContainer.bottomAnchor).isActive = true
        ingredientsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        ingredientsTable.delegate = self
        ingredientsTable.dataSource = self
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension IngredientsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        cell.separatorInset = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! IngredientCell
        
        
        var text = cell.label?.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        if (text?.contains("("))!{
            
            if (text?.contains(","))!{
                var tmp = ""
                let front = text?.substring(to: (text?.index(before: (text?.characters.index(of: "("))!))!)
                tmp = front!
                let back = text?.substring(from: (text?.index(after: (text?.characters.index(of: "("))!))!)
                let divide = text?.components(separatedBy: "(")
                tmp = (divide?[0])!
                
                let subLastCharDivide = back?.substring(to: (back?.index(before: (back?.characters.endIndex)!))!)

                print(subLastCharDivide!)
                for data in (subLastCharDivide?.components(separatedBy: ","))!{
                    tmp += "\(data)"
                }
                text = tmp

                
            }else{
                let index = text?.characters.index(of: "(")
                text = text?.substring(to: (text?.index(before: index!))!)
            }
            
        }
        var urlString: String = "\(text!) For \(appDelegate.after_item_list_filter.pet_type == 0 ? "Dog" : "Cat")"
        
        urlString = urlString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let url = URL(string: "http://www.google.com/search?q=\(urlString)")
        
        UIApplication.shared.open(url!)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath){
        
    }
}

extension IngredientsVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (appDelegate.selected_item?.ingredients.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IngredientCell
        
        var text : String = ""
        text=(appDelegate.selected_item?.ingredients[indexPath.row].name)!

        cell.label.text = text
        cell.label.font = UIFont.systemFont(ofSize: findIconLabelSize(height: cell.frame.height * 0.6, label: cell.label))
        
        return cell
        
    }
}

class IngredientCell : UITableViewCell
{
    var label : UILabel!
    var arrow : UIImageView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupCell()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    func setupCell(){
        
        label = UILabel()
        arrow = UIImageView()
        
        label?.translatesAutoresizingMaskIntoConstraints = false
        arrow?.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label!)
        self.addSubview(arrow!)
        
        let margin : CGFloat = UIScreen.main.bounds.width * 0.043
        
        
        label?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        label?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        label?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        arrow?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
        arrow?.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        arrow?.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        arrow?.widthAnchor.constraint(equalTo: (arrow?.heightAnchor)!).isActive = true
        arrow?.contentMode = .scaleAspectFit
        arrow?.image = UIImage(named: "forward_fit")
        
        
    }
    
}
