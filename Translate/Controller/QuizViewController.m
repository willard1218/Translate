//
//  ViewController.m
//  Translate
//
//  Created by willard on 2017/3/18.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "QuizViewController.h"
#import "WLArticle+CoreDataClass.h"
#import "WLQuiz+CoreDataClass.h"
#import "WLTextView.h"
#import "WLLabel.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

- (void)setup {
    [super setup];
    _questionTextView = [[WLTextView alloc] init];
    _questionTextView.editable = NO;
    _questionTitleLabel = [[WLLabel alloc] init];
    _questionTitleLabel.text = @"題目";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Quiz";
    
    [self.view addSubview:_questionTitleLabel];
    [self.view addSubview:_questionTextView];
    [self addQuestionTitleLabelConstraints];
    [self addQuestionTextViewConstraint];
}

- (void)addQuestionTitleLabelConstraints {
    [_questionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@30);
    }];
}
- (void)addQuestionTextViewConstraint {
    [_questionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_questionTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
}


- (void)setQuiz:(WLQuiz *)quiz {
    _quiz = quiz;
    _questionTextView.text = _quiz.question;
}


@end
