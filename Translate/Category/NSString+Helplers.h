//
//  NSString+Helplers.h
//  Translate
//
//  Created by willard on 2017/4/6.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, TaskState) {
    TaskStatePending,
    TaskStateExecuting,
    TaskStateCompleted
};

@interface NSString (Helplers)

- (double)percentOfGlobishWords;
@end
