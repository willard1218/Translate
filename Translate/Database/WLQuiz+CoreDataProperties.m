//
//  WLQuiz+CoreDataProperties.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLQuiz+CoreDataProperties.h"

@implementation WLQuiz (CoreDataProperties)

+ (NSFetchRequest<WLQuiz *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WLQuiz"];
}

- (void)setupWithDictionary:(NSDictionary *)dict {
    self.question = dict[@"english"];
    self.answer = dict[@"chinese"];
}


@dynamic answer;
@dynamic userAnswer;
@dynamic question;
@dynamic diffWords;
@dynamic article;

@end
