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
    RAC(self.btnSearch, enabled) = self.viewModel.searchButtonEnableSignal;
    RAC(self.tfUserName, enabled) = self.viewModel.searchFieldEnableSignal;

    @weakify(self)
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
