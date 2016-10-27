//
//  TumblrPostCellViewModel.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPostCellViewModel.h"

@interface TumblrPostCellViewModel ()

@property (weak) TumblrPost* post;

@end

@implementation TumblrPostCellViewModel

- (instancetype)initWithTumblrPost: (TumblrPost*)post {
    self = [self init];

    if (self) {
        self.post = post;
    }

    return self;
}

@end
