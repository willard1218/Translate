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

-(void)setText:(NSString *)text {
    _label.text = text;
}

- (void)setupView {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    _label = [[UILabel alloc] init];
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    [self addSubview:_label];
    [self layoutIfNeeded];
}

- (void)setLabelConstraint {
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_label removeConstraints:_label.constraints];
    
    [_label.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = YES;
    
    [_label.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:0].active = YES;
    
    [_label.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    
    CGFloat h = [_label textHeightForWidth:self.frame.size.width];
    
    [_label.heightAnchor constraintEqualToConstant:h].active = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setLabelConstraint];
    CGFloat height = [_label textHeightForWidth:_label.frame.size.width];
    
    CGSize scrollableSize = CGSizeMake(0, height);
    [self setContentSize:scrollableSize];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
}


@end
