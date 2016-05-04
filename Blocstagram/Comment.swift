//
//  Comment.swift
//  Blocstagram
//
//  Created by Jin Kato on 12/16/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class Comment: NSObject {
    var idNumber : NSString = ""
    var from : User?
    var text : NSString = ""
    
    init(commentDictionary:NSDictionary) {
        super.init()
        self.idNumber = commentDictionary["id"] as! String
        self.text = commentDictionary["text"] as! String
        self.from = User(userDictionary: commentDictionary["from"] as! NSDictionary)
    }
}

/*
{
    "created_time": "1401374997",
    "text": "U know u got it",
    "from": {
        "username": "lutherpics",
        "profile_picture": "http:\/\/images.ak.instagram.com\/profiles\/profile_309451969_75sq_1372650775.jpg",
        "id": "309451969",
        "full_name": "Meshelly Luther"
    },
    "id": "731108930889847663"
}
*/