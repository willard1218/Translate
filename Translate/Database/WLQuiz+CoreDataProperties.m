//
//  WLQuiz+CoreDataProperties.m
//  Translate
//
//  Created by willard on 2017/4/26.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLQuiz+CoreDataProperties.h"

@implementation WLQuiz (CoreDataProperties)

+ (NSFetchRequest<WLQuiz *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WLQuiz"];
}

@dynamic answer;
@dynamic question;
@dynamic userAnswer;
@dynamic article;
@dynamic diffWords;
@dynamic notes;
@dynamic parentQuiz;

@end
