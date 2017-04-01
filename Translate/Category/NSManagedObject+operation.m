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

- (void)deleteEntity {
    [[WLCoreDataManager sharedManager] deleteEntity:self];
}

- (void)save {
    [[WLCoreDataManager sharedManager] saveContext];
}
@end
