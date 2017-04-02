//
//  NSManagedObject+operation.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NSManagedObject+operation.h"
#import "WLCoreDataManager.h"
@implementation NSManagedObject (operation)

+ (instancetype)createEntity {
    return [[WLCoreDataManager sharedManager] createEntityWithClass:self.class];
}

+ (instancetype)createEntityWithDict:(NSDictionary *)dict {
    __kindof NSManagedObject *managedObject = [[WLCoreDataManager sharedManager]
                                               createEntityWithClass:self.class];
    
    if (![managedObject respondsToSelector:@selector(setupWithDictionary:)]) {
        NSLog(@"Class %@ not support setupWithDictionary", NSStringFromClass(managedObject.class));
        exit(EXIT_FAILURE);
    }
    
    [managedObject setupWithDictionary:dict];
    return managedObject;
}

+ (NSArray <__kindof NSManagedObject *>*)findAll {
    return [self findAllWithPredicate:nil];
}

+ (NSArray <__kindof NSManagedObject *>*)findAllWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [self fetchRequest];
    fetchRequest.predicate = predicate;
    return [self findWithFetchRequest:fetchRequest];
}

+ (__kindof NSManagedObject *)findFirst {
    return [self findFirstWithPredicate:nil];
}

+ (__kindof NSManagedObject *)findFirstWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [self fetchRequest];
    fetchRequest.predicate = predicate;
    fetchRequest.fetchLimit = 1;
    
    NSArray *results = [self findWithFetchRequest:fetchRequest];
    if (results.count == 0) {
        return nil;
    }
    
    return results[0];
}

+ (NSArray <__kindof NSManagedObject *>*)findWithFetchRequest:(NSFetchRequest *)fetchRequest {
    
    NSError *err;
    NSArray *managedObjects = [[WLCoreDataManager sharedManager] executeFetchRequest:fetchRequest error:&err];
    
    return managedObjects;
}

- (void)deleteEntity {
    [[WLCoreDataManager sharedManager] deleteEntity:self];
}

- (void)save {
    [[WLCoreDataManager sharedManager] saveContext];
}
@end
