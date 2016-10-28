//
//  TumblrPostViewModel.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 28/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TumblrPost;

@interface TumblrPostViewModel : NSObject

@property NSString* htmlContent;

- (instancetype)initWithTumblrPost: (TumblrPost*)post;
- (BOOL)isPhotoPost;
- (NSURL*)getPhotoUrl;
- (CGSize)getPhotoSize;
- (CGSize)getPhotoSizeProportionalToWidth: (int)width;

@end
