//
//  WLArticle+CoreDataClass.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WLQuiz;

NS_ASSUME_NONNULL_BEGIN

@interface WLArticle : NSManagedObject
- (void)setupQuizsWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

#import "WLArticle+CoreDataProperties.h"
