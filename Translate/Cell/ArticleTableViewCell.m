//
//  ArticleTableViewCell.m
//  Translate
//
//  Created by willard on 2017/4/4.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "WLArticle+CoreDataClass.h"
@interface ArticleTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation ArticleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_detailLabel];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@100);
    }];
}

- (void)setupDataWithArticle:(WLArticle *)article {
    _detailLabel.text = [self getMessageWithArticle:article];
}

- (NSString *)getMessageWithArticle:(WLArticle *)article {
    NSArray <NSNumber *> *quizStateCounts = article.quizStateCounts;
    
    switch (article.taskState) {
        case TaskStatePending: {
            if (article.quizs.count == 0) {
                return [NSString stringWithFormat:@"%@", @"not loading".localize];
            }
            
            return [NSString stringWithFormat:@"%lu %@", article.quizs.count, @"quizs".localize];
            break;
        }
        case TaskStateExecuting: {
            return [NSString stringWithFormat:@"%@/%lu", quizStateCounts[TaskStateCompleted], article.quizs.count];
            break;
        }
        case TaskStateCompleted: {
            NSInteger numOfNotes = [[article.quizs valueForKeyPath: @"@sum.notes.count"] integerValue];
            return [NSString stringWithFormat:@"%lu %@", numOfNotes, @"notes".localize];
    
            break;
        }
    }
    
    return nil;
}

@end
