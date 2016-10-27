//
//  SearchUserViewModel.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC.h>

@interface SearchUserViewModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *searchUserName;
@property (strong, nonatomic) RACSignal *validSearchSignal;

@end
