//
//  UITableView+Helper.h
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Helper)

- (void)registerClass:(_Nonnull Class)cellClass;

- (void)registerClassList:(NSArray <Class> *_Nonnull)cellClassList;

- (__kindof UITableViewCell *_Nonnull)dequeueReusableCellWithClass:(_Nonnull Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

@end
