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
    _label = [[UILabel alloc] init];
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
    
    
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.font = [UIFont systemFontOfSize:20];
    self.backgroundColor = [UIColor ADKColorWithHexString:@"FAE243"];
    self.layer.borderColor = [UIColor ADKColorWithHexString:@"3B6DD9"].CGColor;
    self.layer.borderWidth = 3.0;
    self.layer.cornerRadius = 5.0;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self addSubview:_label];
    [self setupView];
}

- (void)addLabelConstraints {
    //self.contentInset = UIEdgeInsetsMake(10, 30, 0, 30);
    
    [_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.top.equalTo(self);
        //make.top.equalTo(self);
        make.width.equalTo(self).offset(-30);
        //make.top.and.left.and.width.equalTo(self);
        CGFloat height = [_label textHeight];
        make.height.equalTo(@(height));
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addLabelConstraints];
    CGFloat height = [_label textHeight];
    
    CGSize scrollableSize = CGSizeMake(0, height);
    [self setContentSize:scrollableSize];
}


@end
