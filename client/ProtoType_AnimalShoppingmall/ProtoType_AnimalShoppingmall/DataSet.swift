//
//  DataSet.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 19..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class DataSet {
    var section : String = ""
    var contents : [Content]?


    init(_section : String, _contents : [Content]){
        section = _section
        contents = _contents
    }

    static private func proteinData() -> DataSet {
        
        var item = [Content]()
        item.append(Content(_content: "Chicken"))
        item.append(Content(_content: "Beef"))
        item.append(Content(_content: "Bone Meal"))
        item.append(Content(_content: "Colostrum"))
        item.append(Content(_content: "Digest/hydrosalate"))
        item.append(Content(_content: "Egg"))
        item.append(Content(_content: "Lamb"))
        item.append(Content(_content: "Duck"))
        item.append(Content(_content: "Liver"))
        item.append(Content(_content: "Rabbit"))
        item.append(Content(_content: "Kangaroo"))
        item.append(Content(_content: "Pork"))
        item.append(Content(_content: "Bison"))
        item.append(Content(_content: "Venison"))
        item.append(Content(_content: "Turkey"))
        item.append(Content(_content: "Mutton"))
        item.append(Content(_content: "Meat and animal alteratives"))
        item.append(Content(_content: "Goat"))
        item.append(Content(_content: "Boar"))
        item.append(Content(_content: "Alligator"))
        item.append(Content(_content: "Tripe"))
        item.append(Content(_content: "Fish"))
        item.append(Content(_content: "Walleye"))
        item.append(Content(_content: "Flounder"))
        item.append(Content(_content: "Arctic char"))
        item.append(Content(_content: "Tuna"))
        item.append(Content(_content: "Swordfish"))
        item.append(Content(_content: "Pilchard"))
        item.append(Content(_content: "Trout"))
        item.append(Content(_content: "Pike"))
        item.append(Content(_content: "Cod"))
        item.append(Content(_content: "Salmon"))
        item.append(Content(_content: "Whitefish"))
        item.append(Content(_content: "Menhaden"))
        item.append(Content(_content: "Pollack"))
        item.append(Content(_content: "Sardines"))
        item.append(Content(_content: "Moose"))
        
        let sorted = item.sorted { (data00, data01) -> Bool in
            return data00.content < data01.content
        }
        
        return DataSet(_section: "Protein", _contents: sorted)
    }
    static private func grainsData() -> DataSet {
        
        var item = [Content]()
        item.append(Content(_content: "Barley"))
        item.append(Content(_content: "Cereals"))
        item.append(Content(_content: "Corn/Maize"))
        item.append(Content(_content: "Maize Germ"))
        item.append(Content(_content: "Maize gluten"))
        item.append(Content(_content: "Millet"))
        item.append(Content(_content: "Oats"))
        item.append(Content(_content: "Rice Brown/whole grain"))
        item.append(Content(_content: "Rice White"))
        item.append(Content(_content: "Rice bran"))
        item.append(Content(_content: "Rice germ"))
        item.append(Content(_content: "Rye"))
        item.append(Content(_content: "Sorghum"))
        item.append(Content(_content: "Spelt"))
        item.append(Content(_content: "Spelt protein"))
        item.append(Content(_content: "Wheat"))
        item.append(Content(_content: "Wheat feed"))
        item.append(Content(_content: "Wheat germ"))


        
        return DataSet(_section: "Grains", _contents: item.sorted { (data00, data01) -> Bool in
            return data00.content < data01.content
        })
    }
    static private func vegetablesData() -> DataSet {
        
        var item = [Content]()
        item.append(Content(_content: "Alfafa/lucern"))
        item.append(Content(_content: "Barley grass"))
        item.append(Content(_content: "Carrots"))
        item.append(Content(_content: "Chicory"))
        item.append(Content(_content: "Garlic"))
        item.append(Content(_content: "Oat grass"))
        item.append(Content(_content: "Pea flour"))
        item.append(Content(_content: "Pea protein"))
        item.append(Content(_content: "Peas"))
        item.append(Content(_content: "Potato Protein"))
        item.append(Content(_content: "Potato starch"))
        item.append(Content(_content: "Potato"))
        item.append(Content(_content: "Sugar beet"))
        item.append(Content(_content: "Sweet potato"))
        item.append(Content(_content: "Tapioca"))
        item.append(Content(_content: "Tomato"))
        item.append(Content(_content: "Vegetable fiber"))
        item.append(Content(_content: "Vegetable oil"))
        item.append(Content(_content: "Vegetable protein extracts"))
        item.append(Content(_content: "Vegetables"))
        item.append(Content(_content: "Wheatgrass"))
        item.append(Content(_content: "Yucca extract"))
        item.append(Content(_content: "Specified vegetables"))


        
        return DataSet(_section: "Vegetables", _contents: item.sorted { (data00, data01) -> Bool in
            return data00.content < data01.content
        })
    }
    static private func plants_SeedsData() -> DataSet {
        
        var item = [Content]()
        item.append(Content(_content: "Borage oil"))
        item.append(Content(_content: "Evening Primrose oil"))
        item.append(Content(_content: "Linseed"))
        item.append(Content(_content: "Psyllium"))
        item.append(Content(_content: "Flaxseed"))
        item.append(Content(_content: "Lupini beans"))
        item.append(Content(_content: "Quinoa"))
        item.append(Content(_content: "Rapeseed oil"))
        item.append(Content(_content: "Soya"))
        item.append(Content(_content: "Soyabean oil"))
        item.append(Content(_content: "Sunflower oil"))
        item.append(Content(_content: "Rosemary"))
        item.append(Content(_content: "Herpagophytum"))
        item.append(Content(_content: "Green tea"))
        item.append(Content(_content: "Herbs"))

        
        return DataSet(_section: "Plants/Seeds", _contents: item.sorted { (data00, data01) -> Bool in
            return data00.content < data01.content
        })
    }
    static private func fruitsData() -> DataSet {
        
        var item = [Content]()
        item.append(Content(_content: "Apples"))
        item.append(Content(_content: "Pear"))
        item.append(Content(_content: "Strawberry"))
        item.append(Content(_content: "Banana"))
        item.append(Content(_content: "Blueberries"))
        item.append(Content(_content: "Cranberries"))
        item.append(Content(_content: "Grape seed oil"))

        
        return DataSet(_section: "Fruits", _contents: item.sorted { (data00, data01) -> Bool in
            return data00.content < data01.content
        })
    }

    
    static func setDataSets() -> [DataSet]{
        return [DataSet.proteinData(),DataSet.grainsData(),DataSet.vegetablesData(),DataSet.plants_SeedsData(),DataSet.fruitsData()]
    }
    
}
class Content{
    var content : String = ""
    var selected : Bool = false
    var reverseSelected : Bool = false
    var include = false
    var exclude = false
    
    init(_content : String){
        content = _content
    }
    init(_content : String, _selected : Bool){
        content = _content
        selected = _selected
    }
}
class AllFilter{
    var content : String = ""
    var section : Int = -1
    var index : Int = -1
    
    init(_content : String, _section : Int, _index : Int){
        index = _index
        section = _section
        content = _content
    }
}

