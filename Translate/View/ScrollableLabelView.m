//
//  ScrollableLabelView.m
//  ViewControllerDemo
//
//  Created by willard on 2017/4/15.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "ScrollableLabelView.h"
#import "UILabel+Utility.h"

@implementation ScrollableLabelView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setText:(NSString *)text {
    
    if ([text isKindOfClass:NSString.class]) {
        _label.text = text;
    } else
        _label.attributedText = (NSAttributedString *)text;
}

- (void)setupView {
    
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:_label];
    [self layoutIfNeeded];
}

- (void)addLabelConstraint {
    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self);
        CGFloat height = [_label textHeightForWidth:self.frame.size.width];
        make.width.equalTo(self.mas_width);
        make.height.equalTo(@(height));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addLabelConstraint];
    CGFloat height = [_label textHeightForWidth:_label.frame.size.width];
    
    CGSize scrollableSize = CGSizeMake(0, height);
    [self setContentSize:scrollableSize];
}


@end
