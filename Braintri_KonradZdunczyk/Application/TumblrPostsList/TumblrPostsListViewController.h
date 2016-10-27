//
//  TumblrPostsListViewController.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TumblrPostsListViewModel;

@interface TumblrPostsListViewController : UIViewController

- (instancetype)initWithTumblrPostsListViewModel: (TumblrPostsListViewModel*)tumblrPostsListViewModel;

@end
