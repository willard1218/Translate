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
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}

- (void)addTitleConstraints {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
}

- (void)addStackViewConstraints {
    [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_scrollView.mas_centerX);
        make.top.and.bottom.equalTo(_scrollView);
    }];
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
        [_stackView addArrangedSubview:t1];
        t1.translatesAutoresizingMaskIntoConstraints = NO;
        t1.backgroundColor = [UIColor whiteColor];
        [t1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@50);
            make.width.equalTo(@(self.frame.size.width-50));
        }];
        
        
    }
}

@end
