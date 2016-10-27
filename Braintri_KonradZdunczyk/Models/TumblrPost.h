//
//  TumblrPost.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TumblrPost : NSObject

@property (nonatomic) NSString* id;
@property (nonatomic) NSURL* url;
@property (nonatomic) NSDate* time;
@property (nonatomic) NSString* format;
@property (nonatomic) NSString* slug;
@property (nonatomic) NSString* typeName;
@property (nonatomic) NSArray<NSString *>* tags;

+ (TumblrPost*)postWithJson: (NSDictionary*)json;
+ (NSArray<TumblrPost*>*)postsWithJsonsArray: (NSArray<NSDictionary*>*)jsons;
- (instancetype)initWithJSON: (NSDictionary*)json;

@end
