//
//  WLArticle+CoreDataProperties.h
//  Translate
//
//  Created by willard on 2017/4/4.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLArticle+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface WLArticle (CoreDataProperties)

+ (NSFetchRequest<WLArticle *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *url;
@property (nonatomic) int16_t identifier;
@property (nullable, nonatomic, retain) NSOrderedSet<WLQuiz *> *quizs;


@end

@interface WLArticle (CoreDataGeneratedAccessors)

- (void)insertObject:(WLQuiz *)value inQuizsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromQuizsAtIndex:(NSUInteger)idx;
- (void)insertQuizs:(NSArray<WLQuiz *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeQuizsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInQuizsAtIndex:(NSUInteger)idx withObject:(WLQuiz *)value;
- (void)replaceQuizsAtIndexes:(NSIndexSet *)indexes withQuizs:(NSArray<WLQuiz *> *)values;
- (void)addQuizsObject:(WLQuiz *)value;
- (void)removeQuizsObject:(WLQuiz *)value;
- (void)addQuizs:(NSOrderedSet<WLQuiz *> *)values;
- (void)removeQuizs:(NSOrderedSet<WLQuiz *> *)values;

@end

NS_ASSUME_NONNULL_END
