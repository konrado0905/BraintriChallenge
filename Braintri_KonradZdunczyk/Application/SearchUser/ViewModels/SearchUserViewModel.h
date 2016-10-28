//
//  SearchUserViewModel.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>
#import "TumblrPostsListViewModel.h"

@interface SearchUserViewModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *searchUserName;

@property (strong, nonatomic) RACSignal *validSearchSignal;
@property (strong, nonatomic) RACSignal *workingSignal;
@property (strong, nonatomic) RACSignal *searchFieldEnableSignal;
@property (strong, nonatomic) RACSignal *searchButtonEnableSignal;

- (void)getTumblrPostsListViewModelWithCompletionHandler: (void (^)(TumblrPostsListViewModel *TumblrPostsListViewModel))completionHandler
                                            errorHandler: (void (^)(NSError* error))errorHandler;

@end
