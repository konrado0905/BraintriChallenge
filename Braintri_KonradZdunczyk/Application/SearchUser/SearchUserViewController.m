//
//  SearchUserViewController.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "SearchUserViewController.h"
#import "TumblrPostsListViewController.h"
#import "UIColor+UIColor_tumblr.h"
#import <Masonry.h>
#import <ReactiveObjC.h>

@interface SearchUserViewController () <UITextFieldDelegate>

@property SearchUserViewModel* viewModel;
@property (weak) UITextField* tfUserName;
@property (weak) UIButton* btnSearch;
@property (weak) UIActivityIndicatorView* activityIndicator;

@property BOOL searchFieldValid;

@end

@implementation SearchUserViewController

- (instancetype)initWithViewModel: (SearchUserViewModel*)viewModel {
    self = [super init];

    if (self) {
        self.viewModel = viewModel;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewSetup];
    [self bindViewModel];
}

- (void)updateViewConstraints {
    [_tfUserName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_tfUserName.superview);
        make.width.equalTo(_tfUserName.superview.mas_width).dividedBy(2);
    }];

    [_btnSearch mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tfUserName.mas_bottom).with.offset(5);
        make.centerX.equalTo(_btnSearch.superview);
        make.leading.greaterThanOrEqualTo(_btnSearch.superview.mas_leadingMargin);
    }];

    [_activityIndicator mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_activityIndicator.superview);
        make.width.height.equalTo(@50);
        make.bottom.equalTo(_tfUserName.mas_top).with.offset(-10);
    }];

    [super updateViewConstraints];
}

- (void)bindViewModel {
    self.title = self.viewModel.title;
    RAC(self.viewModel, searchUserName) = self.tfUserName.rac_textSignal;
    RAC(self.btnSearch, enabled) = self.viewModel.searchButtonEnableSignal;
    RAC(self.tfUserName, enabled) = self.viewModel.searchFieldEnableSignal;
    RAC(self, searchFieldValid) = self.viewModel.validSearchSignal;

    @weakify(self)
    [self.viewModel.workingSignal subscribeNext:^(NSNumber* workingNum) {
        @strongify(self)

        BOOL working = [workingNum boolValue];

        if (working) {
            [self.activityIndicator startAnimating];
        } else {
            [self.activityIndicator stopAnimating];
        }
    }];

    [[_btnSearch rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id  _Nullable x) {
        @strongify(self)

        [self fetchUserAndPresentController];
    }];
}

- (void)fetchUserAndPresentController {
    [self.viewModel getTumblrPostsListViewModelWithCompletionHandler:^(TumblrPostsListViewModel *tumblrPostsListViewModel) {
        [self showPostsListViewControllerWithPostsListViewModel:tumblrPostsListViewModel];
    } errorHandler:^(NSError *error) {
        [self presentAlertControllerWithError:error];
    }];
}

- (void)viewSetup {
    [self.view setBackgroundColor:[UIColor tumblrBlueColor]];

    UITextField* tfUserName = [[UITextField alloc] init];
    [tfUserName setBackgroundColor:[UIColor whiteColor]];
    [tfUserName setTextAlignment:NSTextAlignmentCenter];
    [tfUserName setAutocorrectionType:UITextAutocorrectionTypeNo];
    [tfUserName setReturnKeyType:UIReturnKeySearch];
    tfUserName.delegate = self;

    UIButton* btnSearch = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnSearch setTitle:@"Search" forState:UIControlStateNormal];

    UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityIndicator setHidesWhenStopped:YES];

    [self.view addSubview:tfUserName];
    [self.view addSubview:btnSearch];
    [self.view addSubview:activityIndicator];

    _tfUserName = tfUserName;
    _btnSearch = btnSearch;
    _activityIndicator = activityIndicator;

    [self.view setNeedsUpdateConstraints];
}

- (void)showPostsListViewControllerWithPostsListViewModel: (TumblrPostsListViewModel*) tumblrPostsListViewModel {
    if (!tumblrPostsListViewModel) return;
    TumblrPostsListViewController* vc = [[TumblrPostsListViewController alloc] initWithTumblrPostsListViewModel:tumblrPostsListViewModel];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self showViewController:vc sender:self];
    });
}

- (void)presentAlertControllerWithError: (NSError*)error {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.domain preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

#pragma MARK: - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!_searchFieldValid) return NO;

    [self fetchUserAndPresentController];

    return YES;
}

@end
