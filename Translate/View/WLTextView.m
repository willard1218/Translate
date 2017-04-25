//
//  WLTextView.m
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLTextView.h"

@implementation WLTextView



-(void)willMoveToSuperview:(UIView *)newSuperview {
    [self setupView];
}

- (void)setupView {
    self.font = [UIFont textViewFont];
    self.backgroundColor = [UIColor ADKColorWithHexString:@"FAE243"];
    self.layer.borderColor = [UIColor ADKColorWithHexString:@"3B6DD9"].CGColor;
    self.layer.borderWidth = 3.0;
    self.layer.cornerRadius = 3.0;
    
    CGFloat textPadding = 7;
    self.textContainerInset = UIEdgeInsetsMake(textPadding,
                                               textPadding,
                                               textPadding,
                                               textPadding);
}
@end
