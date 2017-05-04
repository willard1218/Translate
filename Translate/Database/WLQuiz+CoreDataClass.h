//
//  WLQuiz+CoreDataClass.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef NS_ENUM(NSInteger, TaskState) {
    TaskStatePending,
    TaskStateExecuting,
    TaskStateCompleted,
    TaskStateCount,
};

@class WLArticle, WLDiffWord;

NS_ASSUME_NONNULL_BEGIN

@interface WLQuiz : NSManagedObject
@property (nonatomic) TaskState taskState;

- (void)submitWithUserAnswer:(NSString *)userAnswer;
- (NSAttributedString *)attributedString;
- (NSAttributedString *)attributedAnswerString;
- (NSAttributedString *)attributedUserAnswerString;
+ (WLQuiz *)createEntityWithQuestion:(NSString *)question
                              answer:(NSString *)answer
                          userAnswer:(NSString *)userAnswer;
@end

NS_ASSUME_NONNULL_END

#import "WLQuiz+CoreDataProperties.h"
