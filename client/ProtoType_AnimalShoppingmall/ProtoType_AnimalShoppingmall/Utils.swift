//
//  Utils.swift
//  ProjectB_Page00
//
//  Created by ARam on 2017. 1. 19..
//  Copyright © 2017년 aram. All rights reserved.
//

import UIKit

//해당 텍스트에 필요한 높이를 알려주는 함수.
func heightOfLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = text
    
    label.sizeToFit()
    return label.frame.height
}

func heightOfLabel(font:UIFont, width:CGFloat) -> CGFloat{
    let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
    label.numberOfLines = 0
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = font
    label.text = "test"
    label.sizeToFit()
    
    return label.frame.height
}

func widthOfText(font:UIFont, text:String) -> CGFloat{
    let fontAttribute = [NSFontAttributeName: font]
    
    return ((text as NSString).size(attributes: fontAttribute)).width
}

//높이에 맞게 라벨 폰트 사이즈 조절.
public func findIconLabelSize(height : CGFloat, label : UILabel) -> CGFloat{
    //        var prev = heightOfLabel(font: iconLabel.font, width: iconLabel.frame.width)
    //        var current = prev
    var result = label.font.pointSize
    var prevResult = label.font.pointSize
    var finish = false
    repeat {
        let prev = heightOfLabel(font: UIFont.systemFont(ofSize: prevResult), width: label.frame.width)

        var current : CGFloat = 0.0
        let value =  height - prev

        if value > 0 {
            result += 0.25
            current = heightOfLabel(font: UIFont.systemFont(ofSize: result), width: 1000)
            
        }else if value < 0{
            result -= 0.25
            current = heightOfLabel(font: UIFont.systemFont(ofSize: result), width: 1000)
            
        }else {
            result = prevResult
            break
        }
        let value2 = height - current
        if CGFloat(value2) * CGFloat(value) < 0{
            finish = true
            if fabs(value2) > fabs(value) {
                result = prevResult
            }
        }else{
            prevResult = result
        }
    } while (!finish)
    
    return result
}
public func findIconLabelSize(height : CGFloat, label : UILabel, font : String) -> CGFloat{
    //        var prev = heightOfLabel(font: iconLabel.font, width: iconLabel.frame.width)
    //        var current = prev
    var result = label.font.pointSize
    var prevResult = label.font.pointSize
    var finish = false
    repeat {
        let prev = heightOfLabel(font: UIFont(name: font, size: prevResult)!, width: label.frame.width)
        var current : CGFloat = 0.0
        let value =  height - prev
        
        if value > 0 {
            result += 0.25
            current = heightOfLabel(font: UIFont(name: font, size: result)!, width: 1000)
            
        }else if value < 0{
            result -= 0.25
            current = heightOfLabel(font: UIFont(name: font, size: result)!, width: 1000)
            
        }else {
            result = prevResult
            break
        }
        let value2 = height - current
        if CGFloat(value2) * CGFloat(value) < 0{
            finish = true
            if fabs(value2) > fabs(value) {
                result = prevResult
            }
        }else{
            prevResult = result
        }
    } while (!finish)
    
    return result
}
public func resizeImage(image : UIImage, size : CGSize)->UIImage{
    
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
    image.draw(in: rect)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}
extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}
