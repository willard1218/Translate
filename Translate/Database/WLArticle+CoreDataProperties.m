//
//  WLArticle+CoreDataProperties.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLArticle+CoreDataProperties.h"
#import "WLQuiz+CoreDataClass.h"

@implementation WLArticle (CoreDataProperties)

+ (NSFetchRequest<WLArticle *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WLArticle"];
}



@dynamic title;
@dynamic url;
@dynamic quizs;
@dynamic identifier;

@end
