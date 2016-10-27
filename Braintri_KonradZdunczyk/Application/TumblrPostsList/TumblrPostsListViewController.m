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

    UILabel* lblInfo = [[UILabel alloc] init];
    [lblInfo setNumberOfLines:0];
    [lblInfo setTextAlignment:NSTextAlignmentCenter];
    [lblInfo setFont:[UIFont systemFontOfSize:15]];

    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"postCell"];

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
        make.width.equalTo(@20);
    }];

    [_lblInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblName.mas_bottom).with.offset(5);
        make.centerX.equalTo(_lblName.superview);
        make.leadingMargin.equalTo(_lblName.superview);
        make.width.lessThanOrEqualTo(@40);
    }];

    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblInfo.mas_bottom);
        make.leading.trailing.bottom.equalTo(_tableView.superview);
    }];

    [super updateViewConstraints];
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

    TumblrPostCellViewModel* viewModel = _tumblrPostsListViewModel.postCellViewModels[indexPath.row];
    cell.textLabel.text = viewModel.cellTitle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


@end
