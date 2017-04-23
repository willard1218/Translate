//
//  NSObject+Helpers.m
//  Translate
//
//  Created by willard on 2017/4/23.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NSObject+Helpers.h"
#import "RuntimeHelper.h"
@implementation NSObject (Helpers)

+ (void)load {
   swizzleMethod(self.class, @selector(init), @selector(newInit));
}

- (instancetype)newInit {
    if ([self isKindOfClass:NSClassFromString(@"NSTaggedPointerStringCStringContainer")]) {
        return [self newInit];
    }
    
    id obj = [self newInit];
 
    [obj performSelector:@selector(setup)];
    
    return obj;
}

- (void)setup {
    
}
@end
