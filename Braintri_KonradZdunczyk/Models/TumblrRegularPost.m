//
//  TumblrRegularPost.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrRegularPost.h"

@implementation TumblrRegularPost

- (instancetype)initWithJSON: (NSDictionary*)json {
    self = [super initWithJSON:json];

    if (self) {
        self.regularTitle = json[@"regular-title"];
        if (!self.regularTitle) return nil;

        self.regularBody = json[@"regular-body"];
        if (!self.regularBody) return nil;

        self.typeName = @"Text";
    }
    
    return self;
}

@end
