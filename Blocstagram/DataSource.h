//
//  DataSource.h
//  Blocstagram
//
//  Created by Jin Kato on 11/29/15.
//  Copyright © 2015 Jin Kato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject
@property (nonatomic, strong, readonly) NSMutableArray *mediaItems;

+(instancetype) sharedInstance;
- (void)removeItemAtIndex:(uint)index;


@end
