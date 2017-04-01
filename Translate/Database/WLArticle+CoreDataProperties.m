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

- (void)setupWithDictionary:(NSDictionary *)dict {
    self.title = dict[@"title"];
    self.url = dict[@"url"];
    
    for (NSDictionary *quizDict in dict[@"paragraphs"]) {
        WLQuiz *quiz = [WLQuiz createEntityWithDict:quizDict];
        [self addQuizsObject:quiz];
    }
}


@dynamic title;
@dynamic url;
@dynamic quizs;

@end
