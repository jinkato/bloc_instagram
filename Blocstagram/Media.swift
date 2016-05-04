//
//  Media.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

class Media: NSObject {
    var idNumber : NSString = ""
    var user : User?
    var mediaURL : NSURL? = nil
    var image : UIImage? = nil
    var caption : NSString = ""
    var comments : [Comment] = []
    
    init(mediaDictionary:NSDictionary) {
        super.init()
        self.idNumber = mediaDictionary["id"] as! String
        self.user = User(userDictionary: mediaDictionary["user"] as! NSDictionary)
        var imageString = mediaDictionary["images"] as! String
        var resolutionString = mediaDictionary["standard_resolution"] as! String
        var urlString = mediaDictionary["url"] as! String
        var standardResolutionImageURLString:String = imageString + resolutionString + urlString
        print(standardResolutionImageURLString)
        var standardResolutionImageURL = NSURL(string: standardResolutionImageURLString as String)
        
        if(standardResolutionImageURL != nil){
            self.mediaURL = standardResolutionImageURL
        }
        
        var captionDictionary = mediaDictionary["caption"] as! NSDictionary
        if (captionDictionary.isKindOfClass(NSDictionary)){
            self.caption = captionDictionary["text"] as! String
        }else{
            self.caption = ""
        }
        
        // Late
        /*
        NSMutableArray *commentsArray = [NSMutableArray array];
        
        for (NSDictionary *commentDictionary in mediaDictionary[@"comments"][@"data"]) {
        Comment *comment = [[Comment alloc] initWithDictionary:commentDictionary];
        [commentsArray addObject:comment];
        }
        
        self.comments = commentsArray;
        */
    }
}

/*
"caption":{
"created_time":"1343765325",
"text":"Part of my job to watch swimming. #olympics #USAUSAUSA",
"from":{
    "username":"kissinkatkelly",
    "profile_picture":"http:\/\/images.instagram.com\/profiles\/profile_4672491_75sq_1341713095.jpg",
    "id":"4672491",
    "full_name":"kissinkatkelly"
},
"id":"247843973390332239"
}
*/

