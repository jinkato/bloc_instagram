//
//  Util.swift
//  Blocstagram
//
//  Created by Jin Kato on 5/5/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//

import UIKit

var imageCache = NSCache()

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
        if let image = imageCache.objectForKey(imageUrl) {
            imageView.image = image as? UIImage
        }else{
            let downloadQueue = dispatch_queue_create("downloadingImages", nil)
            dispatch_async(downloadQueue){
                let data = NSData(contentsOfURL:NSURL(string: imageUrl)!)
                if data != nil{
                    let imageData = data
                    let image = UIImage(data: imageData!)!
                    imageCache.setObject(image, forKey: imageUrl)
                    dispatch_async(dispatch_get_main_queue(), {
                        imageView.image = image
                    })
                }
            }
        }
        
    }
    
    class func concatenateCommentArray(commentArray:[Comment]) -> String {
        let count = commentArray.count
        var returnString = ""
        for var i = 0; i < count; i++ {
            let name = commentArray[i].from?.fullName as! String
            let comment = commentArray[i].text as String
            returnString = returnString + name + " " + comment + "\n\n"
        }
        return returnString
    }
    
    class func commentAttribute(commentArray:[Comment]) -> NSMutableAttributedString {
        let count = commentArray.count
        let fullString = Utils.concatenateCommentArray(commentArray)
        let commentAttribute = NSMutableAttributedString(string: fullString, attributes: [NSFontAttributeName: Fonts.lightFont])
        var nameStartLocation = 0
        var nameEndLocation = 0
        var characterCount = 0
        for var i = 0; i < count; i++ {
            let name = commentArray[i].from?.fullName as! String
            let nameCount = name.characters.count
            let comment = commentArray[i].text as String
            let commentCount = comment.characters.count + 1
            nameEndLocation = nameStartLocation + nameCount
            commentAttribute.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSRange(location:characterCount,length:nameCount))
            //print("start= \(nameStartLocation)  end= \(nameEndLocation)    namecount=\(nameCount)   commentCount=\(commentCount)")
            nameStartLocation = nameEndLocation + commentCount
            characterCount += (nameCount + commentCount + 3)
        }
        return commentAttribute
    }
}

