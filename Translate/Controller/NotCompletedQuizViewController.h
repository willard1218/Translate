//
//  NotCompletedQuizViewController.h
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "QuizViewController.h"

@interface NotCompletedQuizViewController : QuizViewController <UITextViewDelegate>
@property (nonatomic, strong) UITextView *answerTextView;
@end
