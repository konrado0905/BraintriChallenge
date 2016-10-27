//
//  TumblrPostsListViewModel.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPostsListViewModel.h"

@interface TumblrPostsListViewModel ()

@property Tumblelog* tumblelog;
@property NSArray<TumblrPost*>* posts;

@end

@implementation TumblrPostsListViewModel

- (instancetype)initWithTumblelog: (Tumblelog*)tumblelog andTumblrPosts: (NSArray<TumblrPost*>*)posts {
    self = [super init];

    if (self) {
        self.tumblelog = tumblelog;
        self.posts = posts;

        NSMutableArray* postsViewModel = [NSMutableArray array];
        for (TumblrPost* post in posts) {
            TumblrPostCellViewModel* postViewModel = [[TumblrPostCellViewModel alloc] initWithTumblrPost: post];
            if (postViewModel)
                [postsViewModel addObject: postViewModel];
        }

        self.postCellViewModels = postsViewModel;
    }

    return self;
}

@end
