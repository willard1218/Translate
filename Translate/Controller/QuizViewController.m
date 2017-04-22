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
    
    _questionScrollableLabel.text = @"非常謝謝你，克里斯。能有這個機會第二度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的好評。非常謝謝你，克里斯。能有這個機會第二度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的好評。非常謝謝你，克里斯。能有這個機會第二度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前 ";
    
    [self addQuestionScrollableLabelConstraint];
}

- (void)addQuestionScrollableLabelConstraint {
    _questionScrollableLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_questionScrollableLabel.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:10].active = YES;
    
    [_questionScrollableLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10].active = YES;
    
    [_questionScrollableLabel.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10].active = YES;
    
    [_questionScrollableLabel.heightAnchor constraintEqualToConstant:100].active = YES;
}

@end
