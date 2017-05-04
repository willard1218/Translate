//
//  SelectableTableView.m
//  ViewControllerDemo
//
//  Created by willard on 2017/4/12.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "SelectableTableView.h"

@implementation SelectableTableView

- (void)setup {
    [super setup];
    self.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] init];
    NSArray *itemArray = @[@"Pending", @"Executing", @"Completed"];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
   
}

- (void)didMoveToSuperview {
    [self addSubview:_segmentedControl];
    [self addSubview:_tableView];
    [self addSegmentedControlConstraints];
    [self addTableViewConstraints];
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


- (void)addSegmentedControlConstraints {
    [_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
}

- (void)addTableViewConstraints {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentedControl.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.and.bottom.equalTo(self).offset(-10);
    }];
}

@end
