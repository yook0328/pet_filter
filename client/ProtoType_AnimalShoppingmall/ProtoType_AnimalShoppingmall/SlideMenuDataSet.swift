//
//  SlideMenuDataSet.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 22..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class SlideMenuDataSet {
    var section : String = ""
    var contents : [Content]?
    var selected = false
    
    class Content{
        var content : String = ""
        var selected : Bool = false
        
        init(_content : String){
            content = _content
        }
        init(_content : String, _selected : Bool){
            content = _content
            selected = _selected
        }
    }
    
    init(_section : String, _contents : [Content]){
        section = _section
        contents = _contents
    }
    
    
    static func setSideSlideMenuBarSets() -> [SlideMenuDataSet]{
        var result = [SlideMenuDataSet]()
        var item = [Content]()
        item.append(Content(_content: "브랜드01"))
        item.append(Content(_content: "브랜드02"))
        item.append(Content(_content: "브랜드03"))
        item.append(Content(_content: "브랜드04"))
        item.append(Content(_content: "브랜드05"))
        item.append(Content(_content: "브랜드06"))
        item.append(Content(_content: "브랜드07"))
        
        result.append(SlideMenuDataSet(_section: "브랜드", _contents: item))
        
        var item1 = [Content]()
        item1.append(Content(_content: "주원료01"))
        item1.append(Content(_content: "주원료02"))
        item1.append(Content(_content: "주원료03"))
        item1.append(Content(_content: "주원료04"))
        item1.append(Content(_content: "주원료05"))
        item1.append(Content(_content: "주원료06"))
        item1.append(Content(_content: "주원료07"))
        
        result.append(SlideMenuDataSet(_section: "주원료", _contents: item1))
        
        var item2 = [Content]()
        item2.append(Content(_content: "연령01"))
        item2.append(Content(_content: "연령02"))
        item2.append(Content(_content: "연령03"))
        item2.append(Content(_content: "연령04"))
        item2.append(Content(_content: "연령05"))
        item2.append(Content(_content: "연령06"))
        item2.append(Content(_content: "연령07"))
        
        result.append(SlideMenuDataSet(_section: "연령", _contents: item2))
        var item3 = [Content]()
        item3.append(Content(_content: "견종크기01"))
        item3.append(Content(_content: "견종크기02"))
        item3.append(Content(_content: "견종크기03"))
        item3.append(Content(_content: "견종크기04"))
        item3.append(Content(_content: "견종크기05"))
        item3.append(Content(_content: "견종크기06"))
        item3.append(Content(_content: "견종크기07"))
        
        result.append(SlideMenuDataSet(_section: "견종크기", _contents: item3))
        
        var item4 = [Content]()
        item4.append(Content(_content: "분류01"))
        item4.append(Content(_content: "분류02"))
        item4.append(Content(_content: "분류03"))
        item4.append(Content(_content: "분류04"))
        item4.append(Content(_content: "분류05"))
        item4.append(Content(_content: "분류06"))
        item4.append(Content(_content: "분류07"))
        
        result.append(SlideMenuDataSet(_section: "분류", _contents: item4))
        
        var item5 = [Content]()
        item5.append(Content(_content: "특징01"))
        item5.append(Content(_content: "특징02"))
        item5.append(Content(_content: "특징03"))
        item5.append(Content(_content: "특징04"))
        item5.append(Content(_content: "특징05"))
        item5.append(Content(_content: "특징06"))
        item5.append(Content(_content: "특징07"))
        
        result.append(SlideMenuDataSet(_section: "특징", _contents: item5))
        
        var item6 = [Content]()
        item6.append(Content(_content: "기능01"))
        item6.append(Content(_content: "기능02"))
        item6.append(Content(_content: "기능03"))
        item6.append(Content(_content: "기능04"))
        item6.append(Content(_content: "기능05"))
        item6.append(Content(_content: "기능06"))
        item6.append(Content(_content: "기능07"))
        
        result.append(SlideMenuDataSet(_section: "기능", _contents: item6))
        return result
    }
}

class DataForSideMenu{
    
    var content = ""
    var tag : Int = 0
    var selected = false
    
    init(_content : String, _tag : Int){
        content = _content
        tag = _tag
    }
    
}

