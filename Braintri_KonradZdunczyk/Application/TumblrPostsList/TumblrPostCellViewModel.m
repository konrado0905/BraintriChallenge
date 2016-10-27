//
//  TumblrPostCellViewModel.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPostCellViewModel.h"
#import "TumblrPost.h"

@interface TumblrPostCellViewModel ()

@property (weak) TumblrPost* post;

@end

@implementation TumblrPostCellViewModel

- (instancetype)initWithTumblrPost: (TumblrPost*)post {
    self = [self init];

    if (self) {
        self.post = post;
        _cellTitle = [self cellTitleFromPost:_post];
        _postTypeName = _post.typeName;
    }

    return self;
}

- (NSString*)cellTitleFromPost: (TumblrPost*)post {
    NSString* title = [post.slug stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (!title || title.length == 0) {
        title = @">>>No Title<<<";
    } else {
        title = [title stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    }

    return [title capitalizedString];
}

@end
