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

+ (NSArray <__kindof NSManagedObject *>*)findAll;
+ (NSArray <__kindof NSManagedObject *>*)findAllWithPredicate:(NSPredicate *)predicate;
+ (__kindof NSManagedObject *)findFirst;
+ (__kindof NSManagedObject *)findFirstWithPredicate:(NSPredicate *)predicate;

- (void)deleteEntity;
- (void)save;

- (void)setupWithDictionary:(NSDictionary *)dict;
@end
