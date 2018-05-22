//
//  SearchFilter.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 4. 23..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class SearchFilter{
    public var pet_type : Int = -1;
    public var item_type : Int = -1;
    public var exclude : String = "";
    public var include : String = "";
    
    func resetFiltered(){
        exclude = ""
        include = ""
    }
}
