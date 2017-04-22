//
//  UITableViewCell+Helpers.m
//  ViewControllerDemo
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "UITableViewCell+Helpers.h"

@implementation UITableViewCell (Helpers)
+ (NSString *)identifier {
    NSString *reuseIdentifier = [NSString stringWithFormat:@"%@Identifier", NSStringFromClass(self.class)];
    return reuseIdentifier;
}


@end
