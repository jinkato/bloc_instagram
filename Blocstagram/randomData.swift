//
//  randomData.swift
//  Blocstagram
//
//  Created by Jin Kato on 2/21/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//
// https://github.com/hpique/SwiftSingleton

import UIKit

class RandomData: NSObject {
    static let sharedInstance = RandomData()
    var mediaItems:[Media] = []
    var isRefresing = false
    var isLoadingOlderItems = false
    var accessToken:String = ""
    
    private override init(){
        super.init()
        isRefresing = false
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "registerAccessTokenFromNotification:", name: "accessTokenGetter", object: nil)
    }
    
    func registerAccessTokenFromNotification(myNotification:NSNotification){
        let accessToken = myNotification.object as! String
    }
    
    func accessTokenGetter(myNotification:NSNotification){
        
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
                        RandomData.sharedInstance.mediaItems = self.convertInstagramJsonToArray(instagramData)
                        dispatch_async(dispatch_get_main_queue(), {
                            NSNotificationCenter.defaultCenter().postNotificationName("com.reloadtable", object: nil)
                        })
                    }catch{
                        print("error")
                    }
                }
            }
            task.resume()
        }
    }
    
    func convertInstagramJsonToArray(instagramData:NSDictionary) -> [Media]{
        let tempDictionary = instagramData["data"]
        let tempArray = tempDictionary! as! NSMutableArray
        var returnArray:[Media] = []
        for item in tempArray{
            let tempItem = Media(mediaDictionary: item as! NSDictionary)
            returnArray.append(tempItem)
        }
        return returnArray
    }
    
    
    
    typealias NewItemCompletionBlock = (inout NSError?) -> Void
    
    func requestNewItemsWithCompletionHandler(completionHandler:NewItemCompletionBlock?){
        if(self.isRefresing == false){
            self.isRefresing = true
            // TODO: Add images
            self.isRefresing = false
            
            let minID = "\(self.mediaItems.first)"
            var parameters = NSDictionary()
            
//            if (minID) {
//                parameters = ["min_id" : minID]
//            }
            
            
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
    
}


