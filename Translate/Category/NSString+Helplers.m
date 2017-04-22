//
//  NSString+Helplers.m
//  Translate
//
//  Created by willard on 2017/4/6.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NSString+Helplers.h"

@implementation NSString (Helplers)

+ (NSArray <NSString *>*) globishWords {
    static NSArray *words;
    
    if (words) {
        return words;
    }
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"globishWords" ofType:@"txt"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSString *newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    words = [newStr componentsSeparatedByString:@"\n"];
    return words;
}

- (double)percentOfGlobishWords {
    NSArray <NSString *> *globishWords = [NSString globishWords];
    NSCharacterSet *set = [[NSCharacterSet letterCharacterSet] invertedSet];
    NSArray *arr = [self componentsSeparatedByCharactersInSet:set];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.length > 0"];
    arr = [arr filteredArrayUsingPredicate:predicate] ;
    NSUInteger matchedCount = 0;
    for (NSString *word in arr) {
        NSUInteger idx = [globishWords indexOfObject:word];
        if (idx != NSNotFound) {
            matchedCount++;
        }
    }
    
    return (double)matchedCount / arr.count;
}
@end
