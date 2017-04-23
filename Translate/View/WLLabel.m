//
//  WLLabel.m
//  Translate
//
//  Created by willard on 2017/4/23.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLLabel.h"

@implementation WLLabel

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.font = [UIFont systemFontOfSize:20];
    self.textColor = [UIColor blueColor];
}


@end
