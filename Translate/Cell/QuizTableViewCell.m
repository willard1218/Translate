//
//  QuizTableViewCell.m
//  Translate
//
//  Created by willard on 2017/4/4.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "QuizTableViewCell.h"
#import "WLQuiz+CoreDataClass.h"
@interface QuizTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation QuizTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
    _detailLabel = [[UILabel alloc] init];
    
    [self addSubview:_detailLabel];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
        make.width.equalTo(@100);
    }];
}

- (void)setupDataWithQuiz:(WLQuiz *)quiz {
    _detailLabel.text = [self getMessageWithQuiz:quiz];
}

- (NSString *)getMessageWithQuiz:(WLQuiz *)quiz {
    
    switch (quiz.taskState) {
        case TaskStatePending: {
            NSUInteger wordCount = [quiz.question componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].count;
            return [NSString stringWithFormat:@"%lu %@", wordCount, @"words".localize];
            break;
        }
        case TaskStateExecuting:
            break;
        case TaskStateCompleted: {
            return [NSString stringWithFormat:@"%lu %@", quiz.notes.count, @"notes".localize];
            break;
        }
    }
    return nil;
}
@end
