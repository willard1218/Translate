//
//  WLQuiz+CoreDataClass.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLQuiz+CoreDataClass.h"
#import "WLArticle+CoreDataClass.h"
#import "DiffMatchPatch.h"
#import "WLDiffWord+CoreDataClass.h"

@implementation WLQuiz

- (void)setTaskState:(TaskState)taskState {
    self.taskStateRaw = (int16_t) taskState;
}

- (TaskState)taskState {
    return (TaskState) self.taskStateRaw;
}

+ (WLQuiz *)createEntityWithQuestion:(NSString *)question
                              answer:(NSString *)answer
                          userAnswer:(NSString *)userAnswer {
    WLQuiz *quiz = [WLQuiz createEntity];
    quiz.question = question;
    quiz.answer = answer;
    quiz.userAnswer = userAnswer;
    quiz.taskState = TaskStatePending;
    return quiz;
}

- (void)setupWithDictionary:(NSDictionary *)dict {
    self.question = dict[@"en"];
    self.answer = dict[@"zh-tw"];
}

- (void)submitWithUserAnswer:(NSString *)userAnswer {
    [self deleteDiffWords];
    self.userAnswer = userAnswer;
    
    DiffMatchPatch *dmp = [DiffMatchPatch new];
    dmp.Diff_Timeout = 1;
    
    NSMutableArray<Diff *> *diffResults = [dmp diff_mainOfOldString:self.userAnswer
                                                       andNewString:self.answer];
    
    for (Diff *diff in diffResults) {
        WLDiffWord *diffWord = [WLDiffWord createEntityWithDiff:diff];
        [self addDiffWordsObject:diffWord];
    }
    
    [self filterDiffWords];
}

- (void)deleteDiffWords {
    for (WLDiffWord *diffWord in self.diffWords) {
        [diffWord deleteEntity];
    }
    
    self.diffWords = nil;
}

- (void)filterDiffWords {
    [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(WLDiffWord *diffWord, NSDictionary<NSString *,id> * _Nullable bindings) {
        if (diffWord.text.length == 0) {
            return false;
        }
        
        if ([diffWord.text isEqualToString:@"\n"]) {
            return false;
        }
        return true;
    }];
    
    [self.diffWords.array filteredArrayUsingPredicate:predicate];
}

- (NSArray *)filterDiffWords:(NSArray <WLDiffWord *>*)diffWords
            withoutOperation:(Operation)operation {
    NSPredicate *preficate = [NSPredicate predicateWithFormat:@"self.operation != %d", operation];
    return [diffWords filteredArrayUsingPredicate:preficate];
}


- (NSString *)diffWordsText {
    return [self textWithDiffWords:self.diffWords.array];
}

- (NSAttributedString *)attributedString {
    return [self attributedStringWithDiffWords:self.diffWords.array];
}

- (NSAttributedString *)attributedAnswerString {
    return [self attributedStringWithDiffWords:self.diffWords.array withoutOperation:DIFF_DELETE];
}

- (NSAttributedString *)attributedUserAnswerString {
    return [self attributedStringWithDiffWords:self.diffWords.array withoutOperation:DIFF_INSERT];
}

- (NSAttributedString *)attributedStringWithDiffWords:(NSArray <WLDiffWord *>*)diffWords
                                     withoutOperation:(Operation)operation {
    NSArray<WLDiffWord *> *answerDiffWords = [self filterDiffWords:diffWords
                                                  withoutOperation:operation];
    return [self attributedStringWithDiffWords:answerDiffWords];
}

- (NSAttributedString *)attributedStringWithDiffWords:(NSArray <WLDiffWord *>*)diffWords {
    NSString *diffWordsText = [self textWithDiffWords:diffWords];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:diffWordsText];
    
    NSUInteger idx = 0;
    for (WLDiffWord *diffWord in diffWords) {
        NSUInteger wordLength = diffWord.text.length;
        [attrString addAttributes:diffWord.attributes range:NSMakeRange(idx, wordLength)];
        idx += wordLength;
    }
    
    UIFont *font = [UIFont textViewFont];
    
    [attrString addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, idx)];
    
    return attrString;
}

- (NSString *)textWithDiffWords:(NSArray <WLDiffWord *>*)array {
    NSArray<NSString *> *words = [array valueForKey:@"text"];
    return [words componentsJoinedByString:@""];
}


@end
