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


- (void)setup {
    [super setup];
    [self setupView];
}


- (void)setText:(NSString *)text {

    _text = text;
    _label.text = _text;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    _label.attributedText = _attributedText;
}

- (void)setupView {
    
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
//    [self layoutIfNeeded];
}

- (void)didMoveToSuperview {
    [self addSubview:_label];
}

- (void)addLabelConstraint {
    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.width.equalTo(self);
        CGFloat height = [_label textHeightForWidth:self.frame.size.width];
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
