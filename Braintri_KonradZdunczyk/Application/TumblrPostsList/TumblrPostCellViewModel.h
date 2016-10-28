//
//  TumblrPostCellViewModel.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TumblrPost;

@interface TumblrPostCellViewModel : NSObject

@property NSString* postTitle;
@property NSString* postTypeName;
@property NSString* hashtags;

- (instancetype)initWithTumblrPost: (TumblrPost*)post;

@end
