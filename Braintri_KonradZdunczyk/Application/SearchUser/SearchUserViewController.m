//
//  SearchUserViewController.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "SearchUserViewController.h"
#import <Masonry.h>
#import <ReactiveObjC.h>

@interface SearchUserViewController ()

@property SearchUserViewModel* viewModel;
@property UITextField* tfUserName;
@property UIButton* btnSearch;

@end

@implementation SearchUserViewController

- (instancetype)initWithViewModel: (SearchUserViewModel*)viewModel {
    self = [super init];

    if (self) {
        self.viewModel = viewModel;
        [self viewSetup];
        [self bindViewModel];
    }

    return self;
}

- (void)bindViewModel {
    self.title = self.viewModel.title;
    RAC(self.viewModel, searchUserName) = self.tfUserName.rac_textSignal;
    RAC(self.btnSearch, enabled) = self.viewModel.validSearchSignal;

    [[_btnSearch rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {

    }];
}

- (void)viewSetup {
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

- (void)viewDidLoad {
    [super viewDidLoad];
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
