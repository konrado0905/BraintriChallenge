//
//  TumblrQuotePost.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 26/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrQuotePost.h"

@implementation TumblrQuotePost

- (instancetype)initWithJSON: (NSDictionary*)json {
    self = [super initWithJSON:json];

    if (self) {
        self.quoteText = json[@"quote-text"];
        if (!self.quoteText) return nil;

        self.quoteSource = json[@"quote-source"];
        if (!self.quoteSource) return nil;
    }
    
    return self;
}

@end
