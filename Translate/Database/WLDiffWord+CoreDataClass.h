//
//  WLDiffWord+CoreDataClass.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Diff;
@class WLQuiz;

NS_ASSUME_NONNULL_BEGIN

@interface WLDiffWord : NSManagedObject
+ (instancetype)createEntityWithDiff:(Diff *)diff;
- (NSDictionary<NSString *, id> *)attributes;
@end

NS_ASSUME_NONNULL_END

#import "WLDiffWord+CoreDataProperties.h"
