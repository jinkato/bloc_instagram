//
//  Comment.swift
//  Blocstagram
//
//  Created by Jin Kato on 12/16/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class Comment: NSObject, NSCoding {
    var idNumber : NSString = ""
    var from : User?
    var text : NSString = ""
    
    init(commentDictionary:NSDictionary) {
        super.init()
        self.idNumber = commentDictionary["id"] as! String
        self.text = commentDictionary["text"] as! String
        self.from = User(userDictionary: commentDictionary["from"] as! NSDictionary)
    }
    //unstore
    required init(coder aDecoder: NSCoder) {
        idNumber = aDecoder.decodeObjectForKey("idNumber") as! String
        from = aDecoder.decodeObjectForKey("from") as? User
        text = aDecoder.decodeObjectForKey("text") as! String
    }
    //store
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(idNumber, forKey: "idNumber")
        aCoder.encodeObject(from, forKey: "from")
        aCoder.encodeObject(text, forKey: "text")
    }
    
}