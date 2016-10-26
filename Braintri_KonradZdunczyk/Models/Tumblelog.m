//
//  Tumblelog.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "Tumblelog.h"

@implementation Tumblelog

- (instancetype)initWithJSON: (NSDictionary*)json {
    self = [super init];

    if (self) {
        self.title = json[@"title"];
        if (!self.title) return nil;

        self.info = json[@"description"];
        if (!self.info) return nil;

        self.name = json[@"name"];
        if (!self.name) return nil;
    }
    
    return self;
}

@end
