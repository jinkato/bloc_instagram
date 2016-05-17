//
//  AppDelegate.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/28/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
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
                        let tempDictionary = instagramData["data"]
                        let tempArray = tempDictionary! as! NSMutableArray
                        for item in tempArray{
                            let tempItem = Media(mediaDictionary: item as! NSDictionary)
                            RandomData.sharedInstance.mediaItems2.append(tempItem)
                        }
                        dispatch_async(dispatch_get_main_queue(), {
                            NSNotificationCenter.defaultCenter().postNotificationName("com.reloadtable", object: nil)
                        })
                    }catch{
                        print("catch")
                    }
                }
            }
            task.resume()
        }
        //Setup the next view which is tableview
        let ImagesTableVC:MainTableView = MainTableView()
        self.window?.rootViewController = ImagesTableVC
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Setup Init Screen
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let uinav = UINavigationController()
        let login = InstagramLogin()
        uinav.viewControllers = [login]
        self.window!.rootViewController = uinav
        self.window?.makeKeyAndVisible()
        
        // Setup observer for Token
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "accessTokenGetter:", name: "accessTokenGetter", object: nil)
        return true
    }
    
    
    
    
    
    
    
    
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

