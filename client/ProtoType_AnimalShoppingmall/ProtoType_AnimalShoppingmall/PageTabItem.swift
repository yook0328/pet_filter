//
//  PageTabItem.swift
//  ProtoType_AnimalShoppingmall
//
//  Created by ARam on 2017. 2. 21..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

class PageTabItem {
    var view : UIView?
    var title : String?
    var icon : UIImage?
    
    init(_view : UIView){
        view = _view
    }
    init(_view : UIView, _title : String){
        view = _view
        title = _title
    }
    
}
