//
//  NoteView.m
//  ViewControllerDemo
//
//  Created by willard on 2017/4/15.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView


- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupView];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
}

- (void)addScrollViewConstraints {
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_scrollView.topAnchor constraintEqualToAnchor:_titleLabel.bottomAnchor constant:10].active = YES;
    [_scrollView.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [_scrollView.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
    [_scrollView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
}

- (void)addTitleConstraints {
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [_titleLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active = YES;
    [_titleLabel.widthAnchor constraintEqualToConstant:100].active = YES;
    [_titleLabel.heightAnchor constraintEqualToConstant:20].active = YES;
}

- (void)addStackViewConstraints {
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [_stackView.centerXAnchor constraintEqualToAnchor:_scrollView.centerXAnchor].active= YES;
    [_stackView.topAnchor constraintEqualToAnchor:_scrollView.topAnchor].active = YES;
    [_stackView.bottomAnchor constraintEqualToAnchor:_scrollView.bottomAnchor].active = YES;
}

- (void)setupView {
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    _titleLabel = [[UILabel alloc] init];
    _stackView = [[UIStackView alloc] init];
    _scrollView = [[UIScrollView alloc] init];
   
    [self addSubview:_titleLabel];
    [self addSubview:_scrollView];
    [_scrollView addSubview:_stackView];
    
    
    
    [self addTitleConstraints];
    [self addScrollViewConstraints];
    [self addStackViewConstraints];
    _titleLabel.text = @"Note";
    
    
    _scrollView.backgroundColor = [UIColor grayColor];
    
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.distribution = UIStackViewDistributionEqualCentering;
    _stackView.alignment = UIStackViewAlignmentCenter;
    _stackView.spacing = 10;
    
    for (int i = 0; i < 10; i++) {
        UITextView *t1 = [[UITextView alloc] init];

        t1.translatesAutoresizingMaskIntoConstraints = NO;
        t1.backgroundColor = [UIColor whiteColor];
        [t1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.width.equalTo(self.mas_width).offset(-50);
        }];
        
        [_stackView addArrangedSubview:t1];
    }
}

@end
