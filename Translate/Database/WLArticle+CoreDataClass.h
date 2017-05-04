//
//  WLArticle+CoreDataClass.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "WLQuiz+CoreDataClass.h"
@class WLQuiz;

NS_ASSUME_NONNULL_BEGIN

@interface WLArticle : NSManagedObject
@property (nonatomic, strong) NSArray <NSNumber *> *quizStateCounts;
@property (nonatomic) TaskState taskState;
- (void)setupQuizsWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

#import "WLArticle+CoreDataProperties.h"
