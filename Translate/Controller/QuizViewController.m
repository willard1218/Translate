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
#import "ScrollableLabelView.h"
@interface QuizViewController ()

@end

@implementation QuizViewController

- (void)setup {
    [super setup];
    _questionScrollableLabel = [[ScrollableLabelView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Quiz";
    
    
    [self.view addSubview:_questionScrollableLabel];
    [self addQuestionScrollableLabelConstraint];
}

- (void)addQuestionScrollableLabelConstraint {
    [_questionScrollableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
}

- (void)setQuiz:(WLQuiz *)quiz {
    _quiz = quiz;
    _questionScrollableLabel.text = _quiz.question;
}


@end
