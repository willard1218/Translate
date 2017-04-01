//
//  WLQuiz+CoreDataProperties.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLQuiz+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface WLQuiz (CoreDataProperties)

+ (NSFetchRequest<WLQuiz *> *)fetchRequest;
- (void)submitWithUserAnswer:(NSString *)userAnswer;

@property (nullable, nonatomic, copy) NSString *answer;
@property (nullable, nonatomic, copy) NSString *userAnswer;
@property (nullable, nonatomic, copy) NSString *question;
@property (nullable, nonatomic, retain) NSSet<WLDiffWord *> *diffWords;
@property (nullable, nonatomic, retain) WLArticle *article;

@end

@interface WLQuiz (CoreDataGeneratedAccessors)

- (void)addDiffWordsObject:(WLDiffWord *)value;
- (void)removeDiffWordsObject:(WLDiffWord *)value;
- (void)addDiffWords:(NSSet<WLDiffWord *> *)values;
- (void)removeDiffWords:(NSSet<WLDiffWord *> *)values;

@end

NS_ASSUME_NONNULL_END
