//
//  TumblrPostViewController.m
//  Braintri_KonradZdunczyk
//
//  Created by Konrad Zdunczyk on 28/10/16.
//  Copyright © 2016 Konrad Zdunczyk. All rights reserved.
//

#import "TumblrPostViewController.h"
#import "TumblrPostViewModel.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TumblrPostViewController ()

@property TumblrPostViewModel* tumblrPostViewModel;
@property (weak) UIScrollView* scrollView;
@property (weak) UIImageView* imageView;
@property (weak) UITextView* textView;

@property MASConstraint *textViewHeight;

@end

@implementation TumblrPostViewController

- (instancetype)initWithTumblrPostViewModel: (TumblrPostViewModel*)tumblrPostViewModel {
    self = [super init];

    if (self) {
        _tumblrPostViewModel = tumblrPostViewModel;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self viewSetup];
    [self.view setNeedsUpdateConstraints];
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadPhoto];
    [self loadHtml];

    [super viewDidAppear:animated];
}

- (void)updateViewConstraints {
    [_scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView.superview);
    }];

    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(_imageView.superview);
        make.width.equalTo(self.view);

        CGFloat height = [self.tumblrPostViewModel getPhotoSizeProportionalToWidth: self.view.frame.size.width].height;

        make.height.equalTo([NSNumber numberWithFloat:height]);
    }];

    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(_textView.superview);
        make.top.equalTo(_imageView.mas_bottom);
        make.width.equalTo(self.view);
        self.textViewHeight = make.height.equalTo(self.view);   //[NSNumber numberWithFloat:_textView.contentSize.height])
    }];

    [super updateViewConstraints];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    _textViewHeight.equalTo([NSNumber numberWithFloat:_textView.contentSize.height]);
    [self.scrollView setNeedsUpdateConstraints];
}

- (void)viewSetup {
    UIScrollView* scrollView = [[UIScrollView alloc] init];

    UIImageView* imageView = [[UIImageView alloc] init];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];

    UITextView* textView = [[UITextView alloc] init];
    [textView setEditable:NO];
    [textView setSelectable:NO];
    [textView setScrollEnabled:NO];
    [self.view addSubview:textView];

    [scrollView addSubview:imageView];
    [scrollView addSubview:textView];
    [self.view addSubview:scrollView];

    _scrollView = scrollView;
    _imageView = imageView;
    _textView = textView;
}

- (void)loadPhoto {
    [_imageView sd_setImageWithURL:[_tumblrPostViewModel getPhotoUrl]];
}

- (void)loadHtml {
    NSString* htmlString = _tumblrPostViewModel.htmlContent;
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                            initWithData: [htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil
                                            ];
    _textView.attributedText = attributedString;
}

@end
