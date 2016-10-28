//
//  SearchUserViewModel.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "SearchUserViewModel.h"
#import "TumblrApi.h"

@interface SearchUserViewModel ()

@property NSNumber* working;

@end

@implementation SearchUserViewModel

- (instancetype)init {
    self = [super init];

    if (self) {
        [self initialize];
    }

    return self;
}

- (void)initialize {
    self.title = @"Search user";
    self.searchUserName = @"";
    self.working = [NSNumber numberWithBool:NO];

    self.validSearchSignal =
    [[[RACObserve(self, searchUserName)
      map:^id(NSString *text) {
          return @([text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0);
      }]
     distinctUntilChanged]
     deliverOnMainThread];

    self.workingSignal =
    [[RACObserve(self, working)
     distinctUntilChanged]
     deliverOnMainThread];

    self.searchFieldEnableSignal =
    [[[RACObserve(self, working)
      map:^id(NSNumber* working) {
          return [NSNumber numberWithBool:![working boolValue]];
      }]
     distinctUntilChanged]
     deliverOnMainThread];

    self.searchButtonEnableSignal =
    [[RACSignal combineLatest:@[self.validSearchSignal, self.workingSignal]
                       reduce:^(NSNumber *valid, NSNumber *working) {
                           BOOL enable = [valid boolValue] && ![working boolValue];

                           return [NSNumber numberWithBool:enable];
                       }]
    deliverOnMainThread];
}

- (void)getTumblrPostsListViewModelWithCompletionHandler: (void (^)(TumblrPostsListViewModel *TumblrPostsListViewModel))completionHandler
                                            errorHandler: (void (^)(NSError* error))errorHandler {
    self.working = [NSNumber numberWithBool:YES];

    @weakify(self)
    [TumblrApi fetchContentFromUserWithName:_searchUserName
                          completionHandler:^(Tumblelog *tumblelog, NSArray<TumblrPost *> *posts) {
                              TumblrPostsListViewModel* tumblrPostsListViewModel = [[TumblrPostsListViewModel alloc] initWithTumblelog:tumblelog andTumblrPosts:posts];

                              completionHandler(tumblrPostsListViewModel);

                              @strongify(self)
                              self.working = [NSNumber numberWithBool:NO];
                          } errorHandler:^(NSError *error) {
                              errorHandler(error);

                              @strongify(self)
                              self.working = [NSNumber numberWithBool:NO];
                          }];
}

@end
