//
//  User.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class User: NSObject {
    
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
}