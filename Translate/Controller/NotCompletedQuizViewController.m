//
//  NotCompletedQuizViewController.m
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NotCompletedQuizViewController.h"
#import "ScrollableLabelView.h"
@interface NotCompletedQuizViewController ()

@end

@implementation NotCompletedQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _answerTextView = [[UITextView alloc] init];
    _answerTextView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_answerTextView];
    [self addAnswerTextViewConstraint];
}

- (void)addAnswerTextViewConstraint {
    [_answerTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionScrollableLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];

}
@end
