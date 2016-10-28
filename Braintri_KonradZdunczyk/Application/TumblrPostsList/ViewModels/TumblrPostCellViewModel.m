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
        _postTitle = [self postTitleFromPost:_post];
        _postTypeName = _post.typeName;
        _hashtags = [self hashtagsStringFromPost:_post];
    }

    return self;
}

- (NSString*)postTitleFromPost: (TumblrPost*)post {
    NSString* title = [post.slug stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if (!title || title.length == 0) {
        title = @">>>No Title<<<";
    } else {
        title = [title stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    }

    return [title capitalizedString];
}

- (NSString*)hashtagsStringFromPost: (TumblrPost*)post {
    NSMutableString* hashtags = [NSMutableString string];

    for (NSString* tag in post.tags) {
        [hashtags appendFormat:@"#%@ ", tag];
    }

    return [hashtags stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
