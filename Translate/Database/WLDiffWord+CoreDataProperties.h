//
//  WLDiffWord+CoreDataProperties.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLDiffWord+CoreDataClass.h"
@class Diff;

NS_ASSUME_NONNULL_BEGIN

@interface WLDiffWord (CoreDataProperties)

+ (NSFetchRequest<WLDiffWord *> *)fetchRequest;
+ (instancetype)createEntityWithDiff:(Diff *)diff;

@property (nonatomic) int16_t operation;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, retain) WLQuiz *quiz;

@end

NS_ASSUME_NONNULL_END
