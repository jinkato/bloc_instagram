//
//  randomData.swift
//  Blocstagram
//
//  Created by Jin Kato on 2/21/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//
// https://github.com/hpique/SwiftSingleton

import UIKit
//import WebKit



class RandomData: NSObject {
    static let sharedInstance = RandomData()
    var mediaItems:NSMutableArray = []
    var isRefresing = false
    var isLoadingOlderItems = false
    var accessToken:String = ""
    
    private override init(){
        super.init()
        isRefresing = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "accessTokenGetter:", name: "accessTokenGetter", object: nil)
    }
    
    func accessTokenGetter(myNotification:NSNotification){
        let accessToken = myNotification.object as! String
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlString = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(accessToken)"
            let url:NSURL = NSURL(string: urlString)!
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url){(data, response, error) -> Void in
                if error != nil{
                    print("error = \(error?.localizedDescription) url = \(urlString) data = \(data)")
                }else{
                    do {
                        let instagramData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                        self.parseDataFromFeedDictionary(instagramData)
                    }catch{
                        print("catch")
                    }
                }
            }
            task.resume()
        }
        
    }
    func parseDataFromFeedDictionary(feedDictionary:NSDictionary){
        let mediaArray = feedDictionary["data"] as! NSMutableArray
//        RandomData.sharedInstance.mediaItems = mediaArray
        print("from data in func")
        self.willChangeValueForKey("mediaItems")
        self.mediaItems = mediaArray
        self.didChangeValueForKey("mediaItems")
        //        var tmpMediaItems = NSMutableArray()
        //        for var i = 0; i < mediaArray.count; ++i {
        //            tmpMediaItems.addObject(mediaArray[i])
        //        }
        
//        NSNotificationCenter.defaultCenter().postNotificationName("reload", object:nil)
        //                        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        //                        dispatch_async(dispatch_get_global_queue(priority, 0), {
        //                            dispatch_async(dispatch_get_main_queue(), { //back to the ui queue
        //                            })
        //                        })
    }
    
    
    
    
    
    
    
    
    
    typealias NewItemCompletionBlock = (inout NSError?) -> Void
    
    func requestNewItemsWithCompletionHandler(completionHandler:NewItemCompletionBlock?){
        if(self.isRefresing == false){
            self.isRefresing = true
            // TODO: Add images
            self.isRefresing = false
        }
        if let handler = completionHandler {
            var err:NSError?
            handler(&err)
        }
    }
    func requestOldItemsWithCompletionHandler(completionHandler:NewItemCompletionBlock?){
        if(self.isLoadingOlderItems == false){
            self.isLoadingOlderItems = true
            // TODO: Add images
            self.isLoadingOlderItems = false
        }
        if let handler = completionHandler {
            var err:NSError?
            handler(&err)
        }
    }
    
    /* ---------------------------------------------------- Instagram API */
    func instagramClientID() -> String{
        return "1c46981b5cbd4c238501eb6de8a0e47b"
    }
    
}


