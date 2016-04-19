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
    public static let sharedInstance = RandomData()
    var mediaItems:NSMutableArray = []
    var isRefresing = false
    var isLoadingOlderItems = false
    
    private override init(){
        super.init()
        mediaItems = NSMutableArray(array:addRandomData())
        isRefresing = false
    }
    typealias NewItemCompletionBlock = (inout NSError?) -> Void
    func requestNewItemsWithCompletionHandler(completionHandler:NewItemCompletionBlock?){
        if(self.isRefresing == false){
            self.isRefresing = true
            let imageName = "1.jpg"
            let image = UIImage(named: imageName)
            let media = Media()
            var randomCommentArray:[ Comment ] = []
            media.image = image
            media.user = randomUser()
            media.caption = randomSentance()
            for _ in 1...5 {
                let myRandomComment:Comment = randomComment()
                randomCommentArray.append(myRandomComment)
            }
            media.comments = randomCommentArray
            mediaItems.insertObject(media, atIndex: 0)
            self.isRefresing = false
        }
        if let handler = completionHandler {
            var err:NSError?
            handler(&err)
        }
    }
    func requestOldItemsWithCompletionHandler(){
        if(self.isLoadingOlderItems == false){
            self.isLoadingOlderItems = true
            let imageName = "1.jpg"
            let image = UIImage(named: imageName)
            let media = Media()
            var randomCommentArray:[ Comment ] = []
            media.image = image
            media.user = randomUser()
            media.caption = randomSentance()
            for _ in 1...5 {
                let myRandomComment:Comment = randomComment()
                randomCommentArray.append(myRandomComment)
            }
            media.comments = randomCommentArray
            mediaItems.addObject(media)
            self.isLoadingOlderItems = false
        }
    }
}

/* ---------------------------------------------------- String Func */

func addRandomData() -> Array<Media>{
    var randomMediaItems:[Media] = []
    for i in 1...5 {
        let imageName = "\(i).jpg"
        let image = UIImage(named: imageName)
        let media = Media()
        var randomCommentArray:[ Comment ] = []
        media.image = image
        media.user = randomUser()
        media.caption = randomSentance()
        for _ in 1...5 {
            let myRandomComment:Comment = randomComment()
            randomCommentArray.append(myRandomComment)
        }
        media.comments = randomCommentArray
        randomMediaItems.append(media)
    }
    return randomMediaItems
}

func randomComment() -> Comment{
    let myComment = Comment()
    myComment.from = randomUser()
    myComment.text = randomSentance()
    return myComment
}

func randomUser() -> User{
    let myUser = User()
    myUser.userName = randomString(5...11)
    let firstName = randomString(3...6)
    let lastName = randomString(5...11)
    myUser.fullName = "\(firstName) \(lastName)"
    return myUser
}

func randomSentance() -> String{
    var mySentance = ""
    let sentanceLength:Int = randomNumber(8...25)
    for _ in 1...sentanceLength {
        mySentance += "\(randomString(5...11)) "
    }
    return mySentance
}

/* ---------------------------------------------------- Utility Func */

func randomNumber(range: Range<Int> = 1...6) -> Int {
    let min = range.startIndex
    let max = range.endIndex
    return Int(arc4random_uniform(UInt32(max - min))) + min
}

func randomString(range: Range<Int>) -> String{
    let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let lettersArray = charactersString.characters.map { String($0) }
    let arrayCount = lettersArray.count
    let min = range.startIndex
    let max = range.endIndex
    let lengthOfFinalString = Int(arc4random_uniform(UInt32(max - min))) + min
    var stringToReturn = ""
    let arrayCountMinusOne = arrayCount - 1
    for _ in 0..<lengthOfFinalString {
        stringToReturn += lettersArray[randomNumber(0...arrayCountMinusOne)]
    }
    return String(stringToReturn)
}