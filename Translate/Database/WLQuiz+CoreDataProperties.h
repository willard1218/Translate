//
//  WLQuiz+CoreDataProperties.h
//  Translate
//
//  Created by willard on 2017/4/2.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLQuiz+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface WLQuiz (CoreDataProperties)

+ (NSFetchRequest<WLQuiz *> *)fetchRequest;
- (void)submitWithUserAnswer:(NSString *)userAnswer;
- (NSAttributedString *)attributedString;
- (NSAttributedString *)attributedAnswerString;
- (NSAttributedString *)attributedUserAnswerString;

@property (nullable, nonatomic, copy) NSString *answer;
@property (nullable, nonatomic, copy) NSString *userAnswer;
@property (nullable, nonatomic, copy) NSString *question;
@property (nullable, nonatomic, retain) NSOrderedSet<WLDiffWord *> *diffWords;
@property (nullable, nonatomic, retain) WLArticle *article;

@end

@interface WLQuiz (CoreDataGeneratedAccessors)

- (void)insertObject:(WLDiffWord *)value inDiffWordsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDiffWordsAtIndex:(NSUInteger)idx;
- (void)insertDiffWords:(NSArray<WLDiffWord *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDiffWordsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDiffWordsAtIndex:(NSUInteger)idx withObject:(WLDiffWord *)value;
- (void)replaceDiffWordsAtIndexes:(NSIndexSet *)indexes withDiffWords:(NSArray<WLDiffWord *> *)values;
- (void)addDiffWordsObject:(WLDiffWord *)value;
- (void)removeDiffWordsObject:(WLDiffWord *)value;
- (void)addDiffWords:(NSOrderedSet<WLDiffWord *> *)values;
- (void)removeDiffWords:(NSOrderedSet<WLDiffWord *> *)values;

@end

NS_ASSUME_NONNULL_END
