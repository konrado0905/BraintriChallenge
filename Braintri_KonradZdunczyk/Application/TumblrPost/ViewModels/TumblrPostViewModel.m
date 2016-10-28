//
//  TumblrPostViewModel.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 28/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPostViewModel.h"
#import "TumblrPost.h"
#import "TumblrPhotoPost.h"

@interface TumblrPostViewModel ()

@property (weak) TumblrPost* post;

@end

@implementation TumblrPostViewModel

- (instancetype)initWithTumblrPost: (TumblrPost*)post {
    self = [self init];

    if (self) {
        self.post = post;

        if ([post conformsToProtocol:@protocol(HtmlContent)]) {
            id <HtmlContent> htmlContent = (id <HtmlContent>)post;
            _htmlContent = [htmlContent getHtmlContent];
        }
    }

    return self;
}

- (BOOL)isPhotoPost {
    return [_post isKindOfClass:[TumblrPhotoPost class]];
}

- (NSURL*)getPhotoUrl {
    if (![self isPhotoPost]) return nil;
    TumblrPhotoPost* post = (TumblrPhotoPost*)_post;

    return post.photoUrl_1280;
}

- (CGSize)getPhotoSize {
    if (![self isPhotoPost]) return CGSizeZero;
    TumblrPhotoPost* post = (TumblrPhotoPost*)_post;

    return CGSizeMake(post.width, post.height);
}

- (CGSize)getPhotoSizeProportionalToWidth: (int)width {
    if (![self isPhotoPost]) return CGSizeZero;

    CGSize photoSize = [self getPhotoSize];
    CGFloat newHeight = floor((width * photoSize.height) / photoSize.width);


    return CGSizeMake(width, newHeight);
}

@end
