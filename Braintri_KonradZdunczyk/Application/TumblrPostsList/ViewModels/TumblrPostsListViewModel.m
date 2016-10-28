//
//  TumblrPostsListViewModel.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPostsListViewModel.h"
#import "Tumblelog.h"
#import "TumblrPost.h"
#import "TumblrPostCellViewModel.h"
#import "TumblrPostViewModel.h"

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

        _userName = _tumblelog.title;
        _userInfo = [_tumblelog.info stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

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

- (TumblrPostViewModel*)getTumblrPostViewModelForRow: (NSInteger)row {
    if (row < 0 || row >= [_posts count]) return nil;

    TumblrPost* post = _posts[row];
    return [[TumblrPostViewModel alloc] initWithTumblrPost:post];
}

@end
