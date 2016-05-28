//
//  Media.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class Feed: NSObject {
    var idNumber : NSString = ""
    var mediaURL : NSString = ""
    var image : UIImage? = nil
    var caption : NSString = ""
    var user : User?
    var comments : [Comment] = []
    var commentsDidLoad = false
    
    init(mediaDictionary:NSDictionary) {
        super.init()
        
        // Id
        self.idNumber = mediaDictionary["id"] as! String
        
        //User
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
        
        
        
        // Comment
        //let commentsArray = [Comment]()
        //let tmpCommentDictionary = mediaDictionary["comments"] as! NSDictionary
        //let tempCommentData = tmpCommentDictionary["data"] as! NSDictionary
//        for commentDictionary in tempCommentData {
//            var comment = Comment(commentDictionary: commentDictionary)
//            commentsArray.append(comment)
//            Comment *comment = [[Comment alloc] initWithDictionary:commentDictionary];
//            [commentsArray addObject:comment];
//        }
        //self.comments = commentsArray
        
        
        
        
        
    }
}

