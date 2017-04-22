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



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Quiz";
    _questionScrollableLabel = [[ScrollableLabelView alloc] init];
    
    _questionScrollableLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_questionScrollableLabel];
    
    [self addQuestionScrollableLabelConstraint];
}

- (void)addQuestionScrollableLabelConstraint {
    [_questionScrollableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@100);
    }];
}

- (void)setQuiz:(WLQuiz *)quiz {
    _quiz = quiz;
    _questionScrollableLabel.text = _quiz.question;
}
@end
