//
//  TumblrPostViewController.h
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 28/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TumblrPostViewModel;

@interface TumblrPostViewController : UIViewController

- (instancetype)initWithTumblrPostViewModel: (TumblrPostViewModel*)tumblrPostViewModel;

@end
