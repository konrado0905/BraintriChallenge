//
//  TumblrPostsListViewController.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 27/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPostsListViewController.h"
#import "TumblrPostsListViewModel.h"
#import "TumblrPostCellViewModel.h"
#import "UIColor+UIColor_tumblr.h"
#import "TumblrPostViewModel.h"
#import "TumblrPostViewController.h"
#import "PostsListCell.h"
#import <Masonry.h>

@interface TumblrPostsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property TumblrPostsListViewModel* tumblrPostsListViewModel;

@property (weak) UILabel* lblName;
@property (weak) UILabel* lblInfo;
@property (weak) UITableView* tableView;

@end

@implementation TumblrPostsListViewController

- (instancetype)initWithTumblrPostsListViewModel: (TumblrPostsListViewModel*)tumblrPostsListViewModel {
    self = [super init];

    if (self) {
        _tumblrPostsListViewModel = tumblrPostsListViewModel;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewSetup];
    [self bindViewModel];
}

- (void)bindViewModel {
    _lblName.text = _tumblrPostsListViewModel.userName;
    _lblInfo.text = _tumblrPostsListViewModel.userInfo;
}

- (void)viewSetup {
    [self.view setBackgroundColor:[UIColor tumblrBlueColor]];

    UILabel* lblName = [[UILabel alloc] init];
    [lblName setTextAlignment:NSTextAlignmentCenter];
    [lblName setFont:[UIFont boldSystemFontOfSize:20]];
    [lblName setTextColor:[UIColor lightTextColor]];

    UILabel* lblInfo = [[UILabel alloc] init];
    [lblInfo setNumberOfLines:0];
    [lblInfo setTextAlignment:NSTextAlignmentCenter];
    [lblInfo setFont:[UIFont systemFontOfSize:15]];
    [lblInfo setTextColor:[UIColor lightTextColor]];

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[PostsListCell class] forCellReuseIdentifier:@"postCell"];

    [self.view addSubview:lblName];
    [self.view addSubview:lblInfo];
    [self.view addSubview:tableView];

    _lblName = lblName;
    _lblInfo = lblInfo;
    _tableView = tableView;

    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [_lblName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom).with.offset(5);
        make.centerX.equalTo(_lblName.superview);
        make.leadingMargin.equalTo(_lblName.superview);
        make.height.equalTo(@20);
    }];

    [_lblInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblName.mas_bottom).with.offset(5);
        make.centerX.equalTo(_lblName.superview);
        make.leadingMargin.equalTo(_lblName.superview);
        make.height.lessThanOrEqualTo(@40);
    }];

    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblInfo.mas_bottom);
        make.leading.trailing.bottom.equalTo(_tableView.superview);
    }];

    [super updateViewConstraints];
}

- (void)configureCell: (PostsListCell*)cell withTumblrPostCellViewModel: (TumblrPostCellViewModel*)viewModel {
    cell.lblTitle.text = viewModel.postTitle;
    cell.lblHashtags.text = viewModel.hashtags;
    cell.lblType.text = viewModel.postTypeName;
}

#pragma MARK: - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tumblrPostsListViewModel.postCellViewModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TumblrPostCellViewModel* viewModel = _tumblrPostsListViewModel.postCellViewModels[indexPath.row];
    [self configureCell:(PostsListCell*)cell withTumblrPostCellViewModel:viewModel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    TumblrPostViewModel* viewModel = [_tumblrPostsListViewModel getTumblrPostViewModelForRow:indexPath.row];

    if (viewModel) {
        TumblrPostViewController* vc = [[TumblrPostViewController alloc] initWithTumblrPostViewModel:viewModel];

        [self showViewController:vc sender:self];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
