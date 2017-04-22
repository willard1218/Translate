//
//  UITableView+Helper.m
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "UITableView+Helper.h"

@implementation UITableView (Helper)

- (void)registerClass:(_Nonnull Class)cellClass {
    NSString *reuseIdentifier = NSStringFromClass(cellClass);
    [self registerClass:cellClass forCellReuseIdentifier:reuseIdentifier];
}


- (void)registerClassList:(NSArray <Class>*)cellClassList {
    for (Class class in cellClassList) {
        [self registerClass:class];
    }
}

- (__kindof UITableViewCell *_Nonnull)dequeueReusableCellWithClass:(_Nonnull Class)cellClass forIndexPath:(NSIndexPath *_Nonnull)indexPath {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass) forIndexPath:indexPath];
}

@end
