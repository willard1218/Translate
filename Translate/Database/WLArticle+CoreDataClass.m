//
//  WLArticle+CoreDataClass.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLArticle+CoreDataClass.h"
#import "WLQuiz+CoreDataClass.h"

@implementation WLArticle

- (void)setupWithDictionary:(NSDictionary *)dict {
    self.title = dict[@"title"];
    self.url = dict[@"url"];
    self.identifier = [dict[@"id"] integerValue];
    
}

- (void)setupQuizsWithDictionary:(NSDictionary *)dict {
    self.quizs = [NSOrderedSet orderedSet];
    for (NSDictionary *quizDict in dict[@"paragraphs"]) {
        WLQuiz *quiz = [WLQuiz createEntityWithDict:quizDict];
        [self addQuizsObject:quiz];
        [self save];
    }
}

- (NSArray <NSNumber *> *)quizStateCounts {
    NSMutableArray <NSNumber *> *results = [NSMutableArray arrayWithCapacity:TaskStateCount];
    
    for (int i = 0; i < TaskStateCount; i++) {
        results[i] = @0;
    }
    
    for (WLQuiz *quiz in self.quizs) {
        results[quiz.taskStateRaw] = @([results[quiz.taskStateRaw] integerValue] + 1);
    }
    
    return results.copy;
}

- (TaskState)taskState {
    if (self.quizs.count == 0) {
        return TaskStatePending;
    }
    
    NSArray <NSNumber *> *quizStateCounts = self.quizStateCounts;
    
    if ([quizStateCounts[TaskStateExecuting] intValue] > 0) {
        return TaskStateExecuting;
    }
    
    // count of TaskStateExecuting == 0
    if ([quizStateCounts[TaskStatePending] intValue] == 0) {
        return TaskStateCompleted;
    }
    
    if ([quizStateCounts[TaskStateCompleted] intValue] == 0) {
        return TaskStatePending;
    }
    
    return TaskStateExecuting;
}
@end
