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

@property (nullable, nonatomic, copy) NSString *answer;
@property (nullable, nonatomic, copy) NSString *userAnswer;
@property (nullable, nonatomic, copy) NSString *question;
@property (nullable, nonatomic, retain) WLDiffWord *diffWords;
@property (nullable, nonatomic, retain) WLArticle *article;

@end

NS_ASSUME_NONNULL_END
