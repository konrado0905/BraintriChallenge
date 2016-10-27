//
//  SearchUserViewModel.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "SearchUserViewModel.h"

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

    self.validSearchSignal =
    [[RACObserve(self, searchUserName)
      map:^id(NSString *text) {
          return @([text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0);
      }]
     distinctUntilChanged];
}

@end
