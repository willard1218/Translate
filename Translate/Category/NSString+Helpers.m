//
//  NSString+Helpers.m
//  Translate
//
//  Created by willard on 2017/5/4.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)
- (NSString *)localize {
    return NSLocalizedString(self, nil);
}
@end
