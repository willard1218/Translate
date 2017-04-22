//
//  WLCoreDataManager.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLCoreDataManager.h"

@implementation WLCoreDataManager

+ (WLCoreDataManager *)sharedManager
{
    static WLCoreDataManager *coreDataManager;
    
    if (!coreDataManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            coreDataManager = [[WLCoreDataManager alloc] init];
        });
        
    }
    
    return coreDataManager;
}


- (id)init
{
    self = [super init];
    
    if (self) {
        [self setupManagedObjectContext];
    }
    
    return self;
}


- (void)setupManagedObjectContext
{
    if (_persistentContainer) {
        return;
    }
    
    @synchronized (self) {
       _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
        [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
            if (error != nil) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                abort();
            }
        }];
        
    }
    
    _managedObjectContext = _persistentContainer.viewContext;
}

- (__kindof NSManagedObject *)createEntityWithClass:(Class)cls {
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(cls) inManagedObjectContext:_managedObjectContext];
}

- (void)deleteEntity:(NSManagedObject *)entity {
    [_managedObjectContext deleteObject:entity];
}

- (void)saveContext {
    return;
    NSError *error = nil;
    if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (nullable NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError **)error; {
    return [_managedObjectContext executeFetchRequest:request error:error];
}
@end
