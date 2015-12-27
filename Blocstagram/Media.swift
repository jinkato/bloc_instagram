//
//  Media.swift
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

import UIKit
//import "User.swif"


class Media: NSObject {
    var idNumber : NSString = ""
    var user : User?
    var mediaURL : NSURL? = nil
    var image : UIImage? = nil
    var caption : NSString = ""
    var comments : NSArray = []
}
