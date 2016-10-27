//
//  SearchUserViewController.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "SearchUserViewController.h"
#import <Masonry.h>

@interface SearchUserViewController ()

@property UITextField* tfUserName;
@property UIButton* btnSearch;

@end

@implementation SearchUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewSetup];
}

- (void)viewSetup {
    self.title = @"Search user";
    [self.view setBackgroundColor:[UIColor lightGrayColor]];

    _tfUserName = [[UITextField alloc] init];
    [_tfUserName setBackgroundColor:[UIColor whiteColor]];
    [_tfUserName setTextAlignment:NSTextAlignmentCenter];
    [_tfUserName setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_tfUserName setReturnKeyType:UIReturnKeySearch];

    _btnSearch = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnSearch setTitle:@"Search" forState:UIControlStateNormal];

    [self.view addSubview:_tfUserName];
    [self.view addSubview:_btnSearch];

    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [_tfUserName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tfUserName.superview);
        make.width.equalTo(_tfUserName.superview.mas_width).dividedBy(2);
    }];

    [_btnSearch mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfUserName.mas_bottom).with.offset(5);
        make.centerX.equalTo(_tfUserName.mas_centerX);
        make.leading.greaterThanOrEqualTo(_btnSearch.superview.mas_leadingMargin);
    }];

    [super updateViewConstraints];
}

@end
