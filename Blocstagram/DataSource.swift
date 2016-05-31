//
//  randomData.swift
//  Blocstagram
//
//  Created by Jin Kato on 2/21/16.
//  Copyright © 2016 Jin Kato. All rights reserved.
//
// https://github.com/hpique/SwiftSingleton

import UIKit
import KeychainSwift

/*
let keychain = KeychainSwift()
keychain.set("hello world", forKey: "my key")
keychain.get("my key")
*/

class DataSource: NSObject {
    static let sharedInstance = DataSource()
    var feeds:[Feed] = []
    var isRefresing = false
    var isLoadingOlderItems = false
    var accessToken:String = ""
    let keychain = KeychainSwift()
    
    private override init(){
        super.init()
        isRefresing = false
        if let accessToken = keychain.get("access token") {
            self.accessToken = accessToken
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "registerAccessTokenFromNotification:", name: "registerAccessToken", object: nil)
    }
    
    func registerAccessTokenFromNotification(myNotification:NSNotification){
        self.accessToken = myNotification.object as! String
        self.keychain.set(self.accessToken, forKey: "access token")
        // Notification Send to AppDelegate
        NSNotificationCenter.defaultCenter().postNotificationName("gototable", object: nil)
        // Json
        getFeed()
    }
    
    // MARK: Json 
    
    func getFeed(){
        getFeedJson(getAllCommentFeed)
    }
    
    func getFeedJson(completion: (Void) -> Void){
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlString = "https://api.instagram.com/v1/users/self/media/recent/?access_token=\(self.accessToken)"
            let url:NSURL = NSURL(string: urlString)!
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url){(data, response, error) -> Void in
                if error != nil{
                    print("error = \(error?.localizedDescription) url = \(urlString) data = \(data)")
                }else{
                    do {
                        let instagramData = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                        DataSource.sharedInstance.feeds = self.convertFeedJsonToArray(instagramData)
                        completion()
                    }catch{
                        print("error")
                    }
                }
            }
            task.resume()
        }
    }
    
    func getAllCommentFeed(){
        let count = DataSource.sharedInstance.feeds.count
        for var i = 0; i < count; i++ {
            let mediaId = DataSource.sharedInstance.feeds[i].idNumber as String
            self.getCommentJson(mediaId, location: i)
        }
    }
    
    func getCommentJson(mediaId:String,location:Int){
        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let urlString = "https://api.instagram.com/v1/media/\(mediaId)/comments?access_token=\(self.accessToken)"
            let url:NSURL = NSURL(string: urlString)!
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithURL(url){(data, response, error) -> Void in
                if error != nil{
                    print("error = \(error?.localizedDescription) url = \(urlString) data = \(data)")
                }else{
                    do {
                        let commentDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSDictionary
                        DataSource.sharedInstance.feeds[location].comments = self.convertCommentToArray(commentDict)
                        DataSource.sharedInstance.feeds[location].commentsDidLoad = true
                        self.checkIfAllCommentsLoaded()
                    }catch{
                        print("error")
                    }
                }
            }
            task.resume()
        }
    }
    
    func checkIfAllCommentsLoaded(){
        let feeds = DataSource.sharedInstance.feeds
        var allCommentsLoaded = true
        for feed in feeds {
            if (feed.commentsDidLoad == false) {
                allCommentsLoaded = false
            }
        }
        // If all the comments are loaded reload the table
        if allCommentsLoaded {
            dispatch_async(dispatch_get_main_queue(), {
                NSNotificationCenter.defaultCenter().postNotificationName("com.reloadtable", object: nil)
            })
        }
    }
    
    func convertFeedJsonToArray(instagramData:NSDictionary) -> [Feed]{
        let tempDictionary = instagramData["data"]
        let tempArray = tempDictionary! as! NSMutableArray
        var returnArray:[Feed] = []
        for item in tempArray{
            let tempItem = Feed(mediaDictionary: item as! NSDictionary)
            returnArray.append(tempItem)
        }
        return returnArray
    }
    
    func convertCommentToArray(instagramData:NSDictionary) -> [Comment]{
        let tempDictionary = instagramData["data"]
        let tempArray = tempDictionary! as! NSMutableArray
        
        var returnArray:[Comment] = []
        for item in tempArray{
            let tempItem = Comment(commentDictionary: item as! NSDictionary)
            returnArray.append(tempItem)
        }
        return returnArray
    }
    
    
    
    
    
    
    
    
    
    
    // ------------------------------------ unused
    
    typealias NewItemCompletionBlock = (inout NSError?) -> Void
    
    func requestNewItems(completionHandler:NewItemCompletionBlock?){
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
    func requestOldItems(completionHandler:NewItemCompletionBlock?){
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


