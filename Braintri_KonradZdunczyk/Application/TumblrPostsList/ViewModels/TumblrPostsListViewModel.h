//
//  TumblrPostsListViewModel.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tumblelog;
@class TumblrPostCellViewModel;
@class TumblrPost;
@class TumblrPostViewModel;

@interface TumblrPostsListViewModel : NSObject

@property NSString* userName;
@property NSString* userInfo;
@property NSArray<TumblrPostCellViewModel*>* postCellViewModels;

- (instancetype)initWithTumblelog: (Tumblelog*)tumblelog andTumblrPosts: (NSArray<TumblrPost*>*)posts;
- (TumblrPostViewModel*)getTumblrPostViewModelForRow: (NSInteger)row;

@end
