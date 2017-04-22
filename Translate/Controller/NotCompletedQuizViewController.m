//
//  NotCompletedQuizViewController.m
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NotCompletedQuizViewController.h"
#import "ScrollableLabelView.h"
#import "WLQuiz+CoreDataClass.h"
#import "CompletedQuizViewController.h"
#import "WLTextView.h"
@interface NotCompletedQuizViewController ()

@end

@implementation NotCompletedQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _answerTextView = [[WLTextView alloc] init];
    
    
    [self.view addSubview:_answerTextView];
    [self addAnswerTextViewConstraint];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Comfirm" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)save {
    [self.quiz submitWithUserAnswer:_answerTextView.text];
    CompletedQuizViewController *viewController = [[CompletedQuizViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.quiz = self.quiz;
    
    [self.navigationController pushViewController:viewController animated:YES];
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
