//
//  TumblrApi.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tumblelog.h"
#import "TumblrPost.h"

@interface TumblrApi : NSObject

+ (void)fetchContentFromUserWithName: (NSString*)name
                   completionHandler: (void (^)(Tumblelog *tumblelog, NSArray<TumblrPost*>* posts))completionHandler
                        errorHandler: (void (^)(NSError* error))errorHandler;

@end
