//
//  QuizTableViewCell.h
//  Translate
//
//  Created by willard on 2017/4/4.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLQuiz;

@interface QuizTableViewCell : UITableViewCell
- (void)setupDataWithQuiz:(WLQuiz *)quiz;
@end
