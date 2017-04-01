//
//  WLDiffWord+CoreDataProperties.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLDiffWord+CoreDataProperties.h"

@implementation WLDiffWord (CoreDataProperties)

+ (NSFetchRequest<WLDiffWord *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WLDiffWord"];
}

@dynamic operation;
@dynamic text;
@dynamic quiz;

@end
