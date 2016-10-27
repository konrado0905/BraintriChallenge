//
//  TumblrPost.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPost.h"
#import "TumblrRegularPost.h"
#import "TumblrPhotoPost.h"
#import "TumblrVideoPost.h"
#import "TumblrQuotePost.h"

@implementation TumblrPost

+ (TumblrPost*)postWithJson: (NSDictionary*)json {
    NSString* type = json[@"type"];

    if ([type isEqualToString:@"regular"]) {
        return [[TumblrRegularPost alloc] initWithJSON:json];
    } else if ([type isEqualToString:@"photo"]) {
        return [[TumblrPhotoPost alloc] initWithJSON:json];
//    } else if ([type isEqualToString:@"video"]) {
//        return [[TumblrVideoPost alloc] initWithJSON:json];
    } else if ([type isEqualToString:@"quote"]) {
        return [[TumblrQuotePost alloc] initWithJSON:json];
    }

    return nil;
}

+ (NSArray<TumblrPost*>*)postsWithJsonsArray: (NSArray<NSDictionary*>*)jsons {
    NSMutableArray* posts = [NSMutableArray array];

    for (NSDictionary* json in jsons) {
        TumblrPost* post = [TumblrPost postWithJson:json];
        if (post) {
            [posts addObject:post];
        }
    }

    return posts;
}

- (instancetype)initWithJSON: (NSDictionary*)json {
    self = [super init];

    if (self) {
        self.id = json[@"id"];
        if (!self.id) return nil;

        self.url = [NSURL URLWithString:json[@"url"]];
        if (!self.url) return nil;

        NSNumber* timestamp = json[@"unix-timestamp"];
        if (!timestamp) return nil;
        self.time = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
        if (!self.time) return nil;

        self.format = json[@"format"];
        if (!self.format) return nil;

        self.slug = json[@"slug"];
        if (!self.slug) return nil;


        self.tags = json[@"tags"];
        if (!self.tags) return nil;

        self.typeName = @"Unknown";
    }

    return self;
}

@end
