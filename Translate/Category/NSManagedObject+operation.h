//
//  NSManagedObject+operation.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (operation)
+ (instancetype)createEntity;
+ (instancetype)createEntityWithDict:(NSDictionary *)dict;
- (void)setupWithDictionary:(NSDictionary *)dict;
@end
