//
//  GuaranteedAnalysisVC.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 4. 29..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class GuaranteedAnalysisVC: UIViewController {
    @IBOutlet weak var viewContainer: UIScrollView!

    var mainLabel : UILabel?
    var mainContentsContianer : UIView?
    var filteredData : [[GuaranteedAnalysis]] = [[GuaranteedAnalysis]]()
    // 0 : Crude, 1 : Moisture, 2 : calcium, 3 : phosphorous, 4 : omega, 5 : other
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var otherContainer : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViewContainer()
        
        setupLabel()
        
        setupFilteredData()
        
        setupMainContents()
        
        setupOtherContents()
        
        setupContentSize()
        
        setupHomeButon()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    
    func setupContentSize(){
        viewContainer.contentSize = CGSize(width : 0, height : (otherContainer?.frame.origin.y)! + (otherContainer?.frame.height)!)
    }
    
    func setupViewContainer(){
        self.automaticallyAdjustsScrollViewInsets = false
        viewContainer.contentInset = UIEdgeInsets.zero
        viewContainer.scrollIndicatorInsets = UIEdgeInsets.zero
        viewContainer.contentOffset = CGPoint.zero
        
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
        viewContainer.backgroundColor = UIColor.white
        
        
    }
    
    func setupLabel(){
        mainLabel = UILabel()
        
        self.view.addSubview(mainLabel!)
        
        mainLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabel?.text = "Guaranteed Analysis"
        mainLabel?.font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: UIScreen.main.bounds.height * 0.04, label: mainLabel!))
        mainLabel?.backgroundColor = UIColor.white
        
        var heightConstant = (UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height)
        if (self.navigationController != nil) {
            heightConstant += (self.navigationController?.navigationBar.frame.height)!
        }
        
        mainLabel?.leftAnchor.constraint(equalTo: viewContainer.leftAnchor, constant: UIScreen.main.bounds.width * 0.035).isActive = true
        mainLabel?.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        mainLabel?.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant :UIScreen.main.bounds.height * 0.02 ).isActive = true
        mainLabel?.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.04).isActive = true
        
        
    }
    
    func setupFilteredData(){
        
        let filteredCrude = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "crude") != nil {
                
                return true
            }
            return false
        })
        
        filteredData.append(filteredCrude!)
        
        let moistureValue = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "moisture") != nil {
                
                return true
            }
            return false
        })
        
        filteredData.append(moistureValue!)
        
        let calciumValue = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "calcium") != nil {
                
                return true
            }
            return false
        })
        
        filteredData.append(calciumValue!)
        
        let phosphorousValue = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "phosphorous") != nil {
                
                return true
            }
            return false
        })
        filteredData.append(phosphorousValue!)
        
        let filteredOmega = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "omega") != nil {
                
                return true
            }
            return false
        })
        filteredData.append(filteredOmega!)
        
        let filteredOther = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "omega") == nil && data.name.lowercased().range(of: "phosphorous") == nil &&  data.name.lowercased().range(of: "calcium") == nil && data.name.lowercased().range(of: "moisture") == nil && data.name.lowercased().range(of: "crude") == nil && data.name.lowercased().range(of: "fat content") == nil{
                print(data.name)
                return true
            }
            return false
        })

        
        filteredData.append(filteredOther!)
        
    }
    
    func setupMainContents(){
        
        let margin : CGFloat = 5
        
        mainContentsContianer = UIView()
        
        mainContentsContianer?.backgroundColor = UIColor.white
        viewContainer.addSubview(mainContentsContianer!)
        
        mainContentsContianer?.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        
        mainContentsContianer?.addSubview(protein)
    
        protein.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        protein.topAnchor.constraint(equalTo: (mainContentsContianer?.topAnchor)!, constant: bigMargin).isActive = true
        protein.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!, constant: -2*margin).isActive = true
        protein.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let proteinGage = GA_Gage()
        
        let proteinValue = filteredData[0].filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "protein") != nil {
                return true
            }
            return false
        })
        
        if (proteinValue.count) > 0 {
            let divideValue = proteinValue[0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            proteinGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            proteinGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        //proteinGage.setup(_fullValue: 100, _value: <#T##CGFloat#>, _back_gageColor: <#T##UIColor#>, _gageColor: <#T##UIColor#>)
        proteinGage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(proteinGage)
        
        let proteinLabel = UILabel()
        proteinLabel.translatesAutoresizingMaskIntoConstraints = false
        proteinLabel.text = "\((proteinValue[0].content)) (\((proteinValue[0].Max) ? "Max":"Min"))"
        proteinLabel.font = font
        proteinLabel.textAlignment = .right
        
        let testLabel = UILabel(frame : CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: textHeight))
        testLabel.text = "00.0% (Min)"
        testLabel.font = font
        testLabel.sizeToFit()
        testLabel.layoutIfNeeded()
        
        let per_width = testLabel.frame.width
        let gage_width = (UIScreen.main.bounds.width - 2 * leftMargin) - per_width - 0.001 * (UIScreen.main.bounds.width - 2 * leftMargin)
        
        let height3 = heightOfLabel(text: proteinLabel.text!, font: proteinLabel.font, width: (self.view.frame.width - 2*margin) * 0.2 - margin)
        
        mainContentsContianer?.addSubview(proteinLabel)
        proteinLabel.rightAnchor.constraint(equalTo: (mainContentsContianer?.rightAnchor)!, constant: -leftMargin).isActive = true
        proteinLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        proteinLabel.topAnchor.constraint(equalTo: protein.bottomAnchor, constant: smallMargin).isActive = true
        proteinLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        proteinGage.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        proteinGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        proteinGage.centerYAnchor.constraint(equalTo: proteinLabel.centerYAnchor).isActive = true
        proteinGage.heightAnchor.constraint(equalTo: proteinLabel.heightAnchor, multiplier: 0.8).isActive = true
        ////////////////
        
        ///////////Crude Fat
        let fat = UILabel()
        fat.text = "Crude Fat"
        fat.font = font
        
        fat.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        mainContentsContianer?.addSubview(fat)
        
        fat.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        fat.topAnchor.constraint(equalTo: proteinLabel.bottomAnchor, constant: smallMargin).isActive = true
        fat.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!, constant: -2*margin).isActive = true
        fat.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        var fatValue = filteredData[0].filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "fat") != nil {
                return true
            }
            return false
        })
        
        if fatValue.count  == 0{
            let fatFiltered = appDelegate.selected_item?.guaranteed_analysis.filter({ (data) -> Bool in
                if data.name.lowercased().range(of: "fat") != nil {
                    return true
                }
                return false
            })
            
            fatValue = (fatFiltered?.filter({ (data) -> Bool in
                if data.name.lowercased().range(of: "content") != nil {
                    return true
                }
                return false
            }))!
            
            if (fatValue.count) > 0 {
                fat.text = "Fat Content"
            }
        }
        
        let fatLabel = UILabel()
        fatLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fatLabel.text = (fatValue.count) > 0 ? "\((fatValue[0].content)) (\((fatValue[0].Max) ? "Max":"Min"))" : "0%"
        fatLabel.font = font
        fatLabel.textAlignment = .right
        
        
        
        mainContentsContianer?.addSubview(fatLabel)
        fatLabel.rightAnchor.constraint(equalTo: (mainContentsContianer?.rightAnchor)!, constant: -leftMargin).isActive = true
        fatLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        fatLabel.topAnchor.constraint(equalTo: fat.bottomAnchor, constant: smallMargin).isActive = true
        fatLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let fatGage = GA_Gage()
        
        if (fatValue.count) > 0 {
            let divideValue = fatValue[0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            fatGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            fatGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        
        fatGage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(fatGage)
        
        fatGage.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        fatGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        fatGage.centerYAnchor.constraint(equalTo: fatLabel.centerYAnchor).isActive = true
        fatGage.heightAnchor.constraint(equalTo: fatLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        //////Crude Fibres
        let fibres = UILabel()
        fibres.text = "Crude Fibres"
        fibres.font = font
        
        fibres.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        mainContentsContianer?.addSubview(fibres)
        
        fibres.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        fibres.topAnchor.constraint(equalTo: fatLabel.bottomAnchor, constant: smallMargin).isActive = true
        fibres.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!, constant: -2*margin).isActive = true
        fibres.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let fibresValue = filteredData[0].filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "fibre") != nil {
                return true
            }
            return false
        })
        
        let fibresLabel = UILabel()
        fibresLabel.translatesAutoresizingMaskIntoConstraints = false
        
        fibresLabel.text = (fibresValue.count) > 0 ? "\((fibresValue[0].content)) (\((fibresValue[0].Max) ? "Max":"Min"))" : "0%"
        fibresLabel.font = font
        fibresLabel.textAlignment = .right
        
        
        
        mainContentsContianer?.addSubview(fibresLabel)
        fibresLabel.rightAnchor.constraint(equalTo: (mainContentsContianer?.rightAnchor)!, constant: -leftMargin).isActive = true
        fibresLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        fibresLabel.topAnchor.constraint(equalTo: fibres.bottomAnchor, constant: smallMargin).isActive = true
        fibresLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let fibresGage = GA_Gage()
        
        if (fibresValue.count) > 0 {
            let divideValue = fibresValue[0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            fibresGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            fibresGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        
        fibresGage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(fibresGage)
        
        fibresGage.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        fibresGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        fibresGage.centerYAnchor.constraint(equalTo: fibresLabel.centerYAnchor).isActive = true
        fibresGage.heightAnchor.constraint(equalTo: fibresLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        //// Crude Ash
        let ash = UILabel()
        ash.text = "Crude Ash"
        ash.font = font
        
        ash.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        mainContentsContianer?.addSubview(ash)
        
        ash.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        ash.topAnchor.constraint(equalTo: fibresLabel.bottomAnchor, constant: smallMargin).isActive = true
        ash.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!, constant: -2*margin).isActive = true
        ash.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let ashValue = filteredData[0].filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "ash") != nil {
                return true
            }
            return false
        })
        
        let ashLabel = UILabel()
        ashLabel.translatesAutoresizingMaskIntoConstraints = false
        ashLabel.textAlignment = .right
        
        ashLabel.text = (ashValue.count) > 0 ? "\((ashValue[0].content)) (\((ashValue[0].Max) ? "Max":"Min"))" : "0%"
        ashLabel.font = font
        
        
        
        mainContentsContianer?.addSubview(ashLabel)
        ashLabel.rightAnchor.constraint(equalTo: (mainContentsContianer?.rightAnchor)!, constant: -leftMargin).isActive = true
        ashLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        ashLabel.topAnchor.constraint(equalTo: ash.bottomAnchor, constant: smallMargin).isActive = true
        ashLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let ashGage = GA_Gage()
        
        if (ashValue.count) > 0 {
            let divideValue = ashValue[0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            ashGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            ashGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        
        ashGage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(ashGage)
        
        ashGage.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        ashGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        ashGage.centerYAnchor.constraint(equalTo: ashLabel.centerYAnchor).isActive = true
        ashGage.heightAnchor.constraint(equalTo: ashLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        ///////Moisture
        let moisture = UILabel()
        moisture.text = "Moisture"
        moisture.font = font
        
        moisture.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        mainContentsContianer?.addSubview(moisture)
        
        moisture.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        moisture.topAnchor.constraint(equalTo: ashLabel.bottomAnchor, constant: smallMargin).isActive = true
        moisture.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!, constant: -2*margin).isActive = true
        moisture.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        
        let moistureLabel = UILabel()
        moistureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        moistureLabel.text = (filteredData[1].count) > 0 ? "\((filteredData[1][0].content)) (\((filteredData[1][0].Max) ? "Max":"Min"))" : "0%"
        moistureLabel.font = font
        moistureLabel.textAlignment = .right
        
        
        
        mainContentsContianer?.addSubview(moistureLabel)
        moistureLabel.rightAnchor.constraint(equalTo: (mainContentsContianer?.rightAnchor)!, constant: -leftMargin).isActive = true
        moistureLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        moistureLabel.topAnchor.constraint(equalTo: moisture.bottomAnchor, constant: smallMargin).isActive = true
        moistureLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let moistureGage = GA_Gage()
        
        if (filteredData[1].count) > 0 {
            let divideValue = filteredData[1][0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            moistureGage.setup(_fullValue: 100, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
            
            
        }else {
            moistureGage.setup(_fullValue: 100, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.mainGageColor)
        }
        
        
        moistureGage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(moistureGage)
        
        moistureGage.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        moistureGage.widthAnchor.constraint(equalToConstant: gage_width).isActive = true
        moistureGage.centerYAnchor.constraint(equalTo: moistureLabel.centerYAnchor).isActive = true
        moistureGage.heightAnchor.constraint(equalTo: moistureLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        
        
        ///////////////Calcium
        let midMargin = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ? leftMargin * 0.5 : leftMargin * 0.25
        let subgage_width = 0.99 * (UIScreen.main.bounds.width * 0.5 - midMargin - leftMargin - per_width)
        
        let calcium = UILabel()
        
        calcium.text = "Calcium"
        calcium.font = font
        
        
        calcium.translatesAutoresizingMaskIntoConstraints = false
        
        let height4 = heightOfLabel(text: "Omega 3 Fatty Acids", font: calcium.font, width: self.view.frame.width/2 - 2*margin)
        
        mainContentsContianer?.addSubview(calcium)
        
        calcium.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        calcium.topAnchor.constraint(equalTo: moistureLabel.bottomAnchor, constant: bigMargin).isActive = true
        calcium.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!,multiplier: 0.5 ,constant: -2*margin).isActive = true
        calcium.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let calciumValue : [GuaranteedAnalysis] = filteredData[2]
        
        let calciumLabel = UILabel()
        calciumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        calciumLabel.text = (calciumValue.count) > 0 ? "\((calciumValue[0].content)) (\((calciumValue[0].Max) ? "Max":"Min"))" : "0%"
        calciumLabel.font = font
        calciumLabel.textAlignment = .right
        
        
        
        mainContentsContianer?.addSubview(calciumLabel)
        calciumLabel.rightAnchor.constraint(equalTo: (mainContentsContianer?.centerXAnchor)!, constant: -midMargin).isActive = true
        calciumLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        calciumLabel.topAnchor.constraint(equalTo: calcium.bottomAnchor, constant: smallMargin).isActive = true
        calciumLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let calciumGage = GA_Gage()
        
        if (calciumValue.count) > 0 {
            let divideValue = calciumValue[0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            calciumGage.setup(_fullValue: 10, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
            
            
        }else {
            calciumGage.setup(_fullValue: 10, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
        }
        
        
        calciumGage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(calciumGage)
        
        calciumGage.leftAnchor.constraint(equalTo: (mainContentsContianer!.leftAnchor), constant: leftMargin).isActive = true
        calciumGage.widthAnchor.constraint(equalToConstant: subgage_width).isActive = true
        calciumGage.centerYAnchor.constraint(equalTo: calciumLabel.centerYAnchor).isActive = true
        calciumGage.heightAnchor.constraint(equalTo: calciumLabel.heightAnchor, multiplier: 0.8).isActive = true
        
        ///////////phosphorous
        let phosphorous = UILabel()
        
        phosphorous.text = "Phosphorous"
        phosphorous.font = font
        
        phosphorous.translatesAutoresizingMaskIntoConstraints = false
        
        mainContentsContianer?.addSubview(phosphorous)
        
        phosphorous.leftAnchor.constraint(equalTo: (mainContentsContianer?.centerXAnchor)!, constant: leftMargin).isActive = true
        phosphorous.topAnchor.constraint(equalTo: moistureLabel.bottomAnchor, constant: bigMargin).isActive = true
        phosphorous.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!,multiplier: 0.5 ,constant: -2*margin).isActive = true
        phosphorous.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let phosphorousValue = filteredData[3]
        
        let phosphorousLabel = UILabel()
        phosphorousLabel.translatesAutoresizingMaskIntoConstraints = false
        
        phosphorousLabel.text = (phosphorousValue.count) > 0 ? "\((phosphorousValue[0].content)) (\((phosphorousValue[0].Max) ? "Max":"Min"))" : "0%"
        phosphorousLabel.font = font
        phosphorousLabel.textAlignment = .right
        
        
        
        mainContentsContianer?.addSubview(phosphorousLabel)
        phosphorousLabel.rightAnchor.constraint(equalTo: (mainContentsContianer?.rightAnchor)!, constant: -leftMargin).isActive = true
        phosphorousLabel.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        phosphorousLabel.topAnchor.constraint(equalTo: phosphorous.bottomAnchor, constant: smallMargin).isActive = true
        phosphorousLabel.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let phosphorousGage = GA_Gage()
        
        if (phosphorousValue.count) > 0 {
            let divideValue = phosphorousValue[0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            phosphorousGage.setup(_fullValue: 10, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
            
            
        }else {
            phosphorousGage.setup(_fullValue: 10, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
        }
        
        
        phosphorousGage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(phosphorousGage)
        
        phosphorousGage.leftAnchor.constraint(equalTo: (mainContentsContianer?.centerXAnchor)!, constant: midMargin).isActive = true
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
        
        
        mainContentsContianer?.addSubview(omega3)
        
        omega3.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        omega3.topAnchor.constraint(equalTo: calciumLabel.bottomAnchor, constant: smallMargin * 1.6).isActive = true
        omega3.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!,multiplier: 0.5 ,constant: -2*margin).isActive = true
        omega3.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let omega3Value = filteredData[4].filter({ (data) -> Bool in
            if data.name.lowercased().range(of: "3") != nil {

                return true
            }
            return false
        })
        
        let omega3Label = UILabel()
        omega3Label.translatesAutoresizingMaskIntoConstraints = false
        
        omega3Label.text = (omega3Value.count) > 0 ? "\((omega3Value[0].content)) (\((omega3Value[0].Max) ? "Max":"Min"))" : "0%"
        omega3Label.font = font
        omega3Label.textAlignment = .right
        
        
        
        
        mainContentsContianer?.addSubview(omega3Label)
        omega3Label.rightAnchor.constraint(equalTo: (mainContentsContianer?.centerXAnchor)!, constant: -midMargin).isActive = true
        omega3Label.widthAnchor.constraint(equalToConstant: per_width).isActive = true
        omega3Label.topAnchor.constraint(equalTo: omega3.bottomAnchor, constant: smallMargin).isActive = true
        omega3Label.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
        
        let omega3Gage = GA_Gage()
        
        if (omega3Value.count) > 0 {
            let divideValue = omega3Value[0].content.components(separatedBy: "%")
            
            let value = ((divideValue[0]) as NSString).floatValue
            
            omega3Gage.setup(_fullValue: 10, _value: CGFloat(value), _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
            
            
        }else {
            omega3Gage.setup(_fullValue: 10, _value: 0, _back_gageColor: UIColor.lightGray, _gageColor: myColor.subGageColor)
        }
        
        
        omega3Gage.translatesAutoresizingMaskIntoConstraints = false
        mainContentsContianer?.addSubview(omega3Gage)
        
        omega3Gage.leftAnchor.constraint(equalTo: (mainContentsContianer?.leftAnchor)!, constant: leftMargin).isActive = true
        omega3Gage.widthAnchor.constraint(equalToConstant: subgage_width).isActive = true
        omega3Gage.centerYAnchor.constraint(equalTo: omega3Label.centerYAnchor).isActive = true
        omega3Gage.heightAnchor.constraint(equalTo: omega3Label.heightAnchor, multiplier: 0.8).isActive = true
        
        ///////////phosphorous
        let omega6 = UILabel()
        
        omega6.text = "Omega-6 Fatty Acids"
        omega6.font = font
        
        omega6.translatesAutoresizingMaskIntoConstraints = false
        
        mainContentsContianer?.addSubview(omega6)
        
        omega6.leftAnchor.constraint(equalTo: (mainContentsContianer?.centerXAnchor)!, constant: midMargin).isActive = true
        omega6.topAnchor.constraint(equalTo: calciumLabel.bottomAnchor, constant: smallMargin * 1.6).isActive = true
        omega6.widthAnchor.constraint(equalTo: (mainContentsContianer?.widthAnchor)!,multiplier: 0.5 ,constant: -2*margin).isActive = true
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
        
        
        
        mainContentsContianer?.addSubview(omega6Label)
        omega6Label.rightAnchor.constraint(equalTo: (mainContentsContianer?.rightAnchor)!, constant: -leftMargin).isActive = true
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
        mainContentsContianer?.addSubview(omega6Gage)
        
        omega6Gage.leftAnchor.constraint(equalTo: (mainContentsContianer?.centerXAnchor)!, constant: midMargin).isActive = true
        omega6Gage.widthAnchor.constraint(equalToConstant: subgage_width).isActive = true
        omega6Gage.centerYAnchor.constraint(equalTo: omega6Label.centerYAnchor).isActive = true
        omega6Gage.heightAnchor.constraint(equalTo: omega6Label.heightAnchor, multiplier: 0.8).isActive = true
        //////////See Detail Button
        
        
        //////////////// Container

        mainContentsContianer?.topAnchor.constraint(equalTo: (mainLabel?.bottomAnchor)!).isActive = true
        mainContentsContianer?.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        mainContentsContianer?.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        let heightConstraint = mainContentsContianer?.heightAnchor.constraint(equalToConstant: 10)
        
        heightConstraint?.isActive = true
        
        self.view.layoutIfNeeded()
        
        heightConstraint?.constant = omega6Label.frame.origin.y + omega6Label.frame.size.height

        self.view.layoutIfNeeded()
        print(protein.frame)
    }
    
    func setupOtherContents(){
        
        let leftMargin = UIScreen.main.bounds.width*0.05
        let bigMargin = UIScreen.main.bounds.height * 0.022
        let smallMargin = UIScreen.main.bounds.height * 0.011
        let tmpLabel = UILabel()
        tmpLabel.text = "Test"
        let textHeight = UIScreen.main.bounds.height * 0.024
        let font = UIFont.boldSystemFont(ofSize: findIconLabelSize(height: textHeight, label: tmpLabel))
        

        otherContainer = UIView()
        otherContainer?.backgroundColor = UIColor.white
        
        self.view.addSubview(otherContainer!)
        
        otherContainer?.translatesAutoresizingMaskIntoConstraints = false
        

        var count : CGFloat = 0

        for data in filteredData[5]
        {
            
            let label = UILabel()
            label.text = "\(data.name) \(data.content) \(data.Max ? "(Max)":"(Min)")"
            label.font = font
            otherContainer?.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.leftAnchor.constraint(equalTo: (otherContainer?.leftAnchor)!, constant: leftMargin).isActive = true
            label.widthAnchor.constraint(equalTo: (otherContainer?.widthAnchor)!, constant: -2*leftMargin).isActive = true
            label.topAnchor.constraint(equalTo: (otherContainer?.topAnchor)!, constant: bigMargin + (bigMargin+textHeight)*count).isActive = true
            label.heightAnchor.constraint(equalToConstant: textHeight).isActive = true
            count += 1
            
        }
        
        otherContainer?.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        otherContainer?.widthAnchor.constraint(equalTo: viewContainer.widthAnchor).isActive = true
        otherContainer?.topAnchor.constraint(equalTo: (mainContentsContianer?.bottomAnchor)!, constant: bigMargin).isActive = true
        count = CGFloat(filteredData[5].count)
        otherContainer?.heightAnchor.constraint(equalToConstant: count * (textHeight + bigMargin) + bigMargin).isActive = true
        
        
        
    }
    
    func setupHomeButon(){
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(clickedHome(sender:)))
    }
    func clickedHome(sender : UIBarButtonItem){
        
        let nextViewController = self.navigationController?.viewControllers[0] as! ViewController
        self.navigationController?.popToViewController(nextViewController, animated: true)
    }
}
