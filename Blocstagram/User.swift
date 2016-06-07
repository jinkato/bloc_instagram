//
//  User.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    var idNumber : NSString = ""
    var userName : NSString = ""
    var fullName : NSString = ""
    var profilePictureURL : NSURL? = nil
    var profilePicture : UIImage? = nil
    
    init(userDictionary:NSDictionary) {
        super.init()
        self.idNumber = userDictionary["id"] as! String
        self.userName = userDictionary["username"] as! String
        self.fullName = userDictionary["full_name"] as! String
        let profileURLString:NSString = userDictionary["profile_picture"] as! String
        let profileURL = NSURL(string: profileURLString as String)
        if profileURL != nil{
            self.profilePictureURL = profileURL
        }
    }
    //unstore
    required init(coder aDecoder: NSCoder) {
        idNumber = aDecoder.decodeObjectForKey("idNumber") as! String
        userName = aDecoder.decodeObjectForKey("userName") as! String
        fullName = aDecoder.decodeObjectForKey("fullName") as! String
        profilePictureURL = aDecoder.decodeObjectForKey("profilePictureURL") as? NSURL
        if let myImage = aDecoder.decodeObjectForKey("profilePicture") as? UIImage? {
            self.profilePicture = myImage
        }
    }
    //store
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(idNumber, forKey: "idNumber")
        aCoder.encodeObject(userName, forKey: "userName")
        aCoder.encodeObject(fullName, forKey: "fullName")
        aCoder.encodeObject(profilePictureURL, forKey: "profilePictureURL")
        if let myImage = profilePicture {
            aCoder.encodeObject(myImage, forKey: "profilePicture")
        }
    }
}