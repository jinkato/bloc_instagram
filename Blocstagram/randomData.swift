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
        registerForAccessTokenNotification()
    }
    
    func registerForAccessTokenNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "someFunc:", name: "accessTokenGetter", object: nil)
    }
    
    func someFunc(myNotification:NSNotification){
        accessToken = myNotification.object as! String
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


