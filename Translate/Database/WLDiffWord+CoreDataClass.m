//
//  WLDiffWord+CoreDataClass.m
//  Translate
//
//  Created by willard on 2017/4/1.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLDiffWord+CoreDataClass.h"
#import "WLQuiz+CoreDataClass.h"
#import "DiffMatchPatch.h"

@implementation WLDiffWord
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
                     NSStrikethroughColorAttributeName:[UIColor blackColor],
                     NSBackgroundColorAttributeName:[UIColor redColor]};
        case DIFF_EQUAL:
            return @{};
    }
    
    return nil;
}
@end
