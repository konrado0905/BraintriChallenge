//
//  SearchUserViewController.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchUserViewModel.h"

@interface SearchUserViewController : UIViewController

- (instancetype)initWithViewModel: (SearchUserViewModel*)viewModel;

@end
