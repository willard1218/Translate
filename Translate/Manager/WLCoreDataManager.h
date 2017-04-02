//
//  WLCoreDataManager.h
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface WLCoreDataManager : NSObject

@property (strong, nonatomic) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (WLCoreDataManager *)sharedManager;
- (__kindof NSManagedObject *)createEntityWithClass:(Class)cls;
- (void)deleteEntity:(NSManagedObject *)entity;
- (void)saveContext;
- (nullable NSArray *)executeFetchRequest:(NSFetchRequest *)request error:(NSError **)error;
@end
