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
#import "WLPanel.h"
@interface QuizViewController ()

@end

@implementation QuizViewController

- (void)setup {
    [super setup];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Comfirm" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Quiz";
    _questionPanel = [[WLPanel alloc] init];
    _answerPanel = [[WLPanel alloc] init];
    _userAnswerPanel = [[WLPanel alloc] init];
    
    
    _questionPanel.textView.delegate = self;
    _userAnswerPanel.textView.delegate = self;
    _answerPanel.textView.delegate = self;
    
    _questionPanel.titleLabel.text = @"題目";
    _userAnswerPanel.titleLabel.text = @"答案";
    _answerPanel.titleLabel.text = @"正確答案";
    _questionPanel.textView.editable = NO;
    _answerPanel.textView.editable = NO;
    [self.view addSubview:_questionPanel];
    [self.view addSubview:_userAnswerPanel];
    [self.view addSubview:_answerPanel];
    [self addViewConstraints];
    
    _userAnswerPanel.textView.text = @"非常謝謝您，克里斯。可以有這個機會再度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的好評。";
    _answerPanel.hidden = YES;
}

- (void)addViewConstraints {
    NSNumber *height = @120;
    CGFloat space = 5;
    
    [_questionPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(space);
        make.width.equalTo(self.view).offset(-10);
        make.centerX.equalTo(self.view);
        make.height.equalTo(height);
    }];
 
    [_userAnswerPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_questionPanel.mas_bottom).offset(space);
        make.width.equalTo(self.view).offset(-10);
        make.centerX.equalTo(self.view);
        make.height.equalTo(height);
    }];
    
    [_answerPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userAnswerPanel.mas_bottom).offset(space);
        make.width.equalTo(self.view).offset(-10);
        make.centerX.equalTo(self.view);
        make.height.equalTo(height);
    }];
}

- (void)setQuiz:(WLQuiz *)quiz {
    _quiz = quiz;
    _questionPanel.textView.text = quiz.question;
}

- (void)save {
    [_quiz submitWithUserAnswer:_userAnswerPanel.textView.text];
    _userAnswerPanel.textView.text = nil;
    _userAnswerPanel.textView.attributedText = _quiz.attributedUserAnswerString;
    
    _userAnswerPanel.textView.editable = NO;
    
    
    
    _answerPanel.textView.attributedText = _quiz.attributedAnswerString;
    _answerPanel.hidden = NO;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    UITextRange *selectedRange = [textView selectedTextRange];
    NSString *selectedText = [textView textInRange:selectedRange];
    NSLog(@"%@", selectedText);
    
}
@end
