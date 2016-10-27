//
//  TumblrPostsListViewModel.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tumblelog.h"
#import "TumblrPost.h"
#import "TumblrPostCellViewModel.h"

@interface TumblrPostsListViewModel : NSObject

@property NSArray<TumblrPostCellViewModel*>* postCellViewModels;

- (instancetype)initWithTumblelog: (Tumblelog*)tumblelog andTumblrPosts: (NSArray<TumblrPost*>*)posts;

@end
