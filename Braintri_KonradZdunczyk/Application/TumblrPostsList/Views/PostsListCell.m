//
//  PostsListCell.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 28/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "PostsListCell.h"
#import <Masonry.h>

@interface PostsListCell ()

@end

@implementation PostsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self viewSetup];
    }

    return self;
}

- (void)layoutSubviews {
    [self setNeedsUpdateConstraints];
    [super layoutSubviews];
}

- (void)updateConstraints {
    [_lblTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leadingMargin.topMargin.trailingMargin.equalTo(_lblTitle.superview);
        make.height.equalTo(@30);
    }];

    [_lblHashtags mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblTitle.mas_bottom);
        make.leadingMargin.trailingMargin.equalTo(_lblHashtags.superview);
        make.height.equalTo(@20);
    }];

    [_lblType mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lblHashtags.mas_bottom);
        make.leadingMargin.bottomMargin.trailingMargin.equalTo(_lblType.superview);
        make.height.equalTo(@20);
    }];
    
    [super updateConstraints];
}

- (void)viewSetup {
    UILabel* lblTitle = [[UILabel alloc] init];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:20]];

    UILabel* lblHashtags = [[UILabel alloc] init];
    [lblHashtags setFont:[UIFont italicSystemFontOfSize:15]];
    [lblHashtags setTextColor:[UIColor lightGrayColor]];

    UILabel* lblType = [[UILabel alloc] init];
    [lblType setFont:[UIFont systemFontOfSize:13]];
    [lblType setTextColor:[UIColor orangeColor]];

    [self.contentView addSubview:lblTitle];
    [self.contentView addSubview:lblHashtags];
    [self.contentView addSubview:lblType];

    _lblTitle = lblTitle;
    _lblHashtags = lblHashtags;
    _lblType = lblType;
}

@end
