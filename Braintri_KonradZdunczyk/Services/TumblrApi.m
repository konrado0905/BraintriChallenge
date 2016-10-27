//
//  TumblrApi.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrApi.h"

@implementation TumblrApi

+ (BOOL)validateUserName: (NSString*)userName error: (NSError**)error {
    if (!userName) {
        *error = [NSError errorWithDomain:@"Name can't be nil" code:-1 userInfo:nil];

        return false;
    }

    if ([userName length] == 0) {
        *error = [NSError errorWithDomain:@"Name can't be empty" code:-1 userInfo:nil];

        return false;
    }

    return true;
}

+ (NSURL*)urlForUserName: (NSString*)userName error: (NSError**)error {
    NSString* trimmedName = [userName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![TumblrApi validateUserName:trimmedName error:error]) {
        return nil;
    }

    NSString* urlString = [NSString stringWithFormat:@"https://%@.tumblr.com/api/read/json", trimmedName];
    NSURL* url = [NSURL URLWithString:urlString];

    if (!url) {
        *error = [NSError errorWithDomain:@"Wrong url" code:-1 userInfo:nil];

        return nil;
    }

    return url;
}

+ (NSDictionary*)parseJson: (NSData*)jsonData error: (NSError**)error {
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"var tumblr_api_read = " withString:@""];
    jsonString = [jsonString stringByReplacingCharactersInRange:NSMakeRange([jsonString length] - 2, 1) withString:@""];

    NSData* stringData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:stringData
                                                           options:NSJSONReadingMutableContainers
                                                             error:error];

    return json;
}

+ (void)fetchContentFromUserWithName: (NSString*)name
                   completionHandler: (void (^)(Tumblelog *tumblelog, NSArray<TumblrPost*>* posts))completionHandler
                        errorHandler: (void (^)(NSError* error))errorHandler {
    NSError* error;
    NSURL* url = [TumblrApi urlForUserName:name error:&error];

    if (!url) {
        errorHandler(error);

        return;
    }

    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                                 if (((NSHTTPURLResponse*)response).statusCode == 404) {
                                                                     NSError* error = [NSError errorWithDomain:@"User not found" code:404 userInfo:nil];
                                                                     errorHandler(error);

                                                                     return;
                                                                 }

                                                                 if (error) {
                                                                     errorHandler(error);

                                                                     return;
                                                                 }

                                                                 if (((NSHTTPURLResponse*)response).statusCode != 200) {
                                                                     NSError* error = [NSError errorWithDomain:@"Unknown error" code:-1 userInfo:nil];
                                                                     errorHandler(error);

                                                                     return;
                                                                 }

                                                                 if (!data) {
                                                                     NSError* error = [NSError errorWithDomain:@"No data in response" code:-1 userInfo:nil];
                                                                     errorHandler(error);

                                                                     return;
                                                                 }

                                                                 NSError* jsonSerializationError;
                                                                 NSDictionary* object = [TumblrApi parseJson:data error:&jsonSerializationError];

                                                                 if (jsonSerializationError) {
                                                                     errorHandler(error);

                                                                     return;
                                                                 }

                                                                 NSDictionary* tumblelogJson = object[@"tumblelog"];
                                                                 NSArray* postsJsons = object[@"posts"];

                                                                 if (!tumblelogJson || !postsJsons) {
                                                                     NSError* error = [NSError errorWithDomain:@"Wrong json data" code:-1 userInfo:nil];
                                                                     errorHandler(error);

                                                                     return;
                                                                 }
                                                                 
                                                                 Tumblelog* tumblelog = [[Tumblelog alloc] initWithJSON:tumblelogJson];
                                                                 NSArray* posts = [TumblrPost postsWithJsonsArray:postsJsons];
                                                                 
                                                                 if (!tumblelog || !posts) {
                                                                     NSError* error = [NSError errorWithDomain:@"Json maping error" code:-1 userInfo:nil];
                                                                     errorHandler(error);
                                                                     
                                                                     return;
                                                                 }
                                                                 
                                                                 completionHandler(tumblelog, posts);
                                                             }];

    [task resume];
}

@end
