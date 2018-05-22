//
//  DogFood.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 3. 27..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class DogFood{
    public var name : String = ""
    public var id : Int = -1
    public var brand : String = ""
    public var type : String = ""
    public var description : String = ""
    public var picture_name : String = ""
    
    public var ingredients = [FoodContent]()
    
    public var nutritional_options = [FoodContent]()
    public var guaranteed_analysis = [GuaranteedAnalysis]()
    
    public var createAt : Date = Date()
    public var updateAt : Date = Date()
    public var item_image : UIImage?
    
    init( _id : Int, _name : String, _brand : String, _type : String, _description : String, _picture_name : String, _createdAt : Date, _updateAt : Date, _GA : Array<Any>, _ingredients : String) {
        
        id = _id
        name = _name
        brand = _brand
        type = _type
        description = _description
        picture_name = _picture_name
        createAt = _createdAt
        updateAt = _updateAt
        
        for ga in _GA{
            let item = ga as! [String:Any]
            guaranteed_analysis.append(GuaranteedAnalysis(_name: item["guaranteed_analysis_name"] as! String, _content: item["guaranteed_analysis_content"] as! String, _Max: item["guaranteed_analysis_maxOrmin"] as! Bool))
        }
        
//        let ingrdientDatas = _ingredients.components(separatedBy: ",")
//        
//        for ingredient in ingrdientDatas
//        {
//            ingredients.append(FoodContent(_name: ingredient))
//        }
        ingredientsDivider(_ingredients: _ingredients)
    }
    init(){
        
    }
    func ingredientsDivider(_ingredients : String){
        let ingredientDatas = _ingredients.components(separatedBy: ",")
        
        var isCheck = false
        var data = ""
        var checkBracket = 0
        
        for ingredient in ingredientDatas{
            
            if !isCheck {
                if ingredient.contains("(") {
                    checkBracket += 1
                    if ingredient.contains(")"){
                        ingredients.append(FoodContent(_name: ingredient))
                        checkBracket -= 1
                    }else{
                        data = ingredient
                        isCheck = true
                    }
                }else {
                    ingredients.append(FoodContent(_name: ingredient))
                }
            }else{
                data += ", \(ingredient)"
                if ingredient.contains("("){
                    var ctmp = 0
                    for char in ingredient.characters{
                        if char == "("{
                            ctmp += 1
                        }
                    }
                    checkBracket += ctmp
                }
                if ingredient.contains(")"){
                    var ctmp = 0
                    for char in ingredient.characters{
                        if char == ")"{
                            ctmp += 1
                        }
                    }
                    checkBracket -= ctmp
                    if checkBracket == 0 {
                        isCheck = false
                        ingredients.append(FoodContent(_name: data))
                    }
                    
                }
            }
            
        }
        
        
    }
    
}

class FoodContent{
    var name : String = ""
    var id : Int = -1
    init(_name : String){
        name = _name
    }
}

class GuaranteedAnalysis{
    var name : String = ""
    var id : Int = -1
    var content : String = ""
    var Max : Bool = false
    init(_name : String, _content : String, _Max: Bool)
    {
        name = _name
        content = _content
        Max = _Max
    }
}
