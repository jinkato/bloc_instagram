//
//  DataSource.h
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

@end
