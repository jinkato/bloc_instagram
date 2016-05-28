//
//  Util.swift
//  Blocstagram
//
//  Created by Jin Kato on 5/5/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

class Utils {
    
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    class func returnNewImageHeight (image:UIImage, viewWith:CGFloat) -> CGFloat{
        let imageHeight = image.size.height
        let imageWidth = image.size.width
        let theRatio = imageHeight/imageWidth
        let finalHeight = viewWith * theRatio
        //print("imageHeight = \(imageHeight)       imageWidth = \(imageWidth)   ")
        return finalHeight
    }
    
    class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    class func asyncLoadImage(imageUrl:String, imageView:UIImageView){
        let downloadQueue = dispatch_queue_create("downloadingImages", nil)
        dispatch_async(downloadQueue){
            let data = NSData(contentsOfURL:NSURL(string: imageUrl)!)
            if data != nil{
                let imageData = data
                dispatch_async(dispatch_get_main_queue(), {
                    let image = UIImage(data: imageData!)!
                    imageView.image = image
                })
            }
        }
    }
}


/*

func getStringFromJSON(data:NSDictionary, key: String) -> String{
if let info = data[key] as? String{
return info
}
return ""
}

*/


/*

//Util Func
func setImageHeightConstraint(cell:FeedCell, viewWith:CGFloat){
let originalHeight = cell.mainImageView.image!.size.height
let originalWidth = cell.mainImageView.image!.size.width
let theRatio = originalHeight/originalWidth
let imageHeight:CGFloat = viewWith * theRatio
cell.myAddConstraint("V:[mainImageView(\(imageHeight))]", view: cell.mainImageView, viewsDictionary: ["mainImageView":cell.mainImageView])
cell.myAddConstraint("H:|[mainImageView]|", view: cell.mainImageView, viewsDictionary: ["mainImageView":cell.mainImageView])
}
*/

/*

func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
label.numberOfLines = 0
label.lineBreakMode = NSLineBreakMode.ByWordWrapping
label.font = font
label.text = text
label.sizeToFit()
return label.frame.height
}
func findRadioHeightBigger(theImage:UIImage) -> CGFloat{
let sizeOfImage = theImage.size
let imageWidth = sizeOfImage.width
let imageHeight = sizeOfImage.height
let theRatio = imageHeight/imageWidth
return theRatio
}
func findRadioWidthBigger(theImage:UIImage) -> CGFloat{
let sizeOfImage = theImage.size
let imageWidth = sizeOfImage.width
let imageHeight = sizeOfImage.height
let theRatio = imageWidth/imageHeight
return theRatio
}

*/
