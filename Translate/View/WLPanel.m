//
//  WLTextViewPanel.m
//  Translate
//
//  Created by willard on 2017/4/23.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLPanel.h"
#import "WLTextView.h"

@implementation WLPanel

- (void)setup {
    [super setup];
    _textView = [[WLTextView alloc] init];
    _titleView = [[UIView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textColor = [UIColor blueColor];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self addSubview:_titleView];
    [_titleView addSubview:_titleLabel];
    [self addSubview:_textView];
    [self addViewConstraints];
}

- (void)addViewConstraints {
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_titleView);
        make.width.equalTo(@100);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom).offset(3);
        make.left.right.equalTo(self);
        make.height.equalTo(@80);
    }];
}


@end
