//
//  WLTextView.m
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLTextView.h"

@implementation WLTextView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.font = [UIFont systemFontOfSize:20];
    self.backgroundColor = [UIColor ADKColorWithHexString:@"FAE243"];
    self.layer.borderColor = [UIColor ADKColorWithHexString:@"3B6DD9"].CGColor;
    self.layer.borderWidth = 3.0;
    self.layer.cornerRadius = 5.0;
}
@end
