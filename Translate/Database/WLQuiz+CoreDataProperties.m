//
//  WLQuiz+CoreDataProperties.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLQuiz+CoreDataProperties.h"
#import "WLDiffWord+CoreDataClass.h"
#import "DiffMatchPatch.h"

@implementation WLQuiz (CoreDataProperties)

+ (NSFetchRequest<WLQuiz *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WLQuiz"];
}

- (void)setupWithDictionary:(NSDictionary *)dict {
    self.question = dict[@"english"];
    self.answer = dict[@"chinese"];
}

- (void)submitWithUserAnswer:(NSString *)userAnswer {
    self.userAnswer = userAnswer;
    
    DiffMatchPatch *dmp = [DiffMatchPatch new];
    dmp.Diff_Timeout = 1;
    
    NSMutableArray <Diff *>*diffResults = [dmp diff_mainOfOldString:self.answer
                                                       andNewString:self.userAnswer];
    
    for (Diff *diff in diffResults) {
        WLDiffWord *diffWord = [WLDiffWord createEntityWithDiff:diff];
        [self addDiffWordsObject:diffWord];
    }
}

@dynamic answer;
@dynamic userAnswer;
@dynamic question;
@dynamic diffWords;
@dynamic article;

@end
