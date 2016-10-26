//
//  TumblrPhotoPost.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPhotoPost.h"

@implementation TumblrPhotoPost

- (instancetype)initWithJSON: (NSDictionary*)json {
    self = [super initWithJSON:json];

    if (self) {
        self.photoCaption = json[@"photo-caption"];
        if (!self.photoCaption) return nil;

        self.width = [json[@"width"] intValue];
        self.height = [json[@"height"] intValue];

        self.photoUrl_1280 = [NSURL URLWithString:json[@"photo-url-1280"]];
        if (!self.photoUrl_1280) return nil;

        self.photoUrl_500 = [NSURL URLWithString:json[@"photo-url-500"]];
        if (!self.photoUrl_500) return nil;

        self.photoUrl_400 = [NSURL URLWithString:json[@"photo-url-400"]];
        if (!self.photoUrl_400) return nil;

        self.photoUrl_250 = [NSURL URLWithString:json[@"photo-url-250"]];
        if (!self.photoUrl_250) return nil;

        self.photoUrl_100 = [NSURL URLWithString:json[@"photo-url-100"]];
        if (!self.photoUrl_100) return nil;

        self.photoUrl_75 = [NSURL URLWithString:json[@"photo-url-75"]];
        if (!self.photoUrl_75) return nil;

        NSArray* photosJsons = json[@"photos"];
        NSMutableArray* photos = [NSMutableArray array];
        for (NSDictionary* photoJson in photosJsons) {
            Photo* photo = [[Photo alloc] initWithJSON:photoJson];
            if (photo) {
                [photos addObject:photo];
            }
        }
        self.photos = photos;
    }
    
    return self;
}

@end
