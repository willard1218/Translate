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
    
    _segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_segmentedControl.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active = YES;
    
    [_segmentedControl.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-10].active = YES;
    
    [_segmentedControl.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    
    [_segmentedControl.heightAnchor constraintEqualToConstant:50].active = YES;
}

- (void)setupTableView {
    _tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;

    [_tableView.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active = YES;
    
    [_tableView.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-10].active = YES;
    
    [_tableView.topAnchor constraintEqualToAnchor:_segmentedControl.bottomAnchor constant:10].active = YES;
    
    [_tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-10].active = YES;
    
}

@end
