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
    self.question = dict[@"en"];
    self.answer = dict[@"zh-tw"];
}

- (void)submitWithUserAnswer:(NSString *)userAnswer {
    [self deleteDiffWords];
    [self filterDiffWords];
    self.userAnswer = userAnswer;
    
    DiffMatchPatch *dmp = [DiffMatchPatch new];
    dmp.Diff_Timeout = 1;
    
    NSMutableArray<Diff *> *diffResults = [dmp diff_mainOfOldString:self.userAnswer
                                                       andNewString:self.answer];
    
    for (Diff *diff in diffResults) {
        WLDiffWord *diffWord = [WLDiffWord createEntityWithDiff:diff];
        [self addDiffWordsObject:diffWord];
    }
}

- (void)deleteDiffWords {
    for (WLDiffWord *diffWord in self.diffWords) {
        [diffWord deleteEntity];
    }
    
    self.diffWords = nil;
}

- (void)filterDiffWords {
    [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id diffWord, NSDictionary<NSString *,id> * _Nullable bindings) {
        return true;
    }];
    
    [self.diffWords.array filteredArrayUsingPredicate:predicate];
}

- (NSString *)diffWordsText {
    NSArray<NSString *> *words = [self.diffWords.array valueForKey:@"text"];
    return [words componentsJoinedByString:@""];
}

- (NSAttributedString *)attributedString {
    NSString *diffWordsText = [self diffWordsText];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:diffWordsText];
    
    NSUInteger idx = 0;
    for (WLDiffWord *diffWord in self.diffWords) {
        NSUInteger wordLength = diffWord.text.length;
        [attrString addAttributes:diffWord.attributes range:NSMakeRange(idx, wordLength)];
        idx += wordLength;
    }
    
    return attrString;
}



@dynamic answer;
@dynamic userAnswer;
@dynamic question;
@dynamic diffWords;
@dynamic article;

@end
