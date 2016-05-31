//
//  Media.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class Feed: NSObject, NSCoding {
    var idNumber : NSString = ""
    var mediaURL : NSString = ""
    var image : UIImage? = nil
    var caption : NSString = ""
    var user : User?
    var comments : [Comment] = []
    var commentsDidLoad = false
    
    init(mediaDictionary:NSDictionary) {
        super.init()
        self.idNumber = mediaDictionary["id"] as! String
        self.user = User(userDictionary: mediaDictionary["user"] as! NSDictionary)
        
        // Image
        let imageString = mediaDictionary["images"] as! NSDictionary
        let resolutionString = imageString["standard_resolution"] as! NSDictionary
        self.mediaURL = resolutionString["url"] as! String

        // Caption
        let captionDictionary = mediaDictionary["caption"]!
        let testDictionary = captionDictionary.isKindOfClass(NSDictionary)
        if testDictionary {
            let myCaption = captionDictionary["text"] as! String
            self.caption = myCaption
        }else{
            self.caption = ""
        }
    }
    //unstore
    required init(coder aDecoder: NSCoder) {
        idNumber = aDecoder.decodeObjectForKey("name") as! String
       if let myImage = aDecoder.decodeObjectForKey("image") as? UIImage? {
            self.image = myImage
        }
        
    }
    //store
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(idNumber, forKey: "name")
        aCoder.encodeObject(image, forKey: "image")
    }
}

