//
//  SelectableTableView.m
//  ViewControllerDemo
//
//  Created by willard on 2017/4/12.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "SelectableTableView.h"

@implementation SelectableTableView


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSegmentedControl];
        [self setupTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)updateConstraintsIfNeeded {
    [super updateConstraintsIfNeeded];
}

- (void)layoutIfNeeded {
    [super layoutIfNeeded];
}


- (void)setupSegmentedControl {
    NSArray *itemArray = @[@"One", @"Two", @"Three"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [self addSubview:_segmentedControl];
    
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}

@end
