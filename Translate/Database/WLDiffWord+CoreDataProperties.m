//
//  WLDiffWord+CoreDataProperties.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLDiffWord+CoreDataProperties.h"
#import "DiffMatchPatch.h"

@implementation WLDiffWord (CoreDataProperties)

+ (NSFetchRequest<WLDiffWord *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"WLDiffWord"];
}

+ (instancetype)createEntityWithDiff:(Diff *)diff {
    WLDiffWord *diffWord = [WLDiffWord createEntity];
    diffWord.text = diff.text;
    diffWord.operation = diff.operation;
    return diffWord;
}

@dynamic operation;
@dynamic text;
@dynamic quiz;

@end
