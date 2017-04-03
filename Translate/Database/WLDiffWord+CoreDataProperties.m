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

- (NSDictionary<NSString *, id> *)attributes {
    switch (self.operation) {
        case DIFF_INSERT:
            return @{NSBackgroundColorAttributeName:[UIColor greenColor]};
        case DIFF_DELETE:
            return @{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),
                     NSStrikethroughColorAttributeName:[UIColor redColor],
                     NSBackgroundColorAttributeName:[UIColor blueColor]};
        case DIFF_EQUAL:
            return @{};
    }
    
    return nil;
}

@dynamic operation;
@dynamic text;
@dynamic quiz;

@end
