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
@interface QuizViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *diffWordsLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;
@end

@implementation QuizViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Quiz";
    _questionLabel.text = _quiz.question;
    _answerTextView.delegate = self;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _answerTextView.text = nil;
    return YES;
}


- (IBAction)submit:(UIButton *)sender {
    [_answerTextView resignFirstResponder];
    [_quiz submitWithUserAnswer:_answerTextView.text];
    _diffWordsLabel.attributedText = _quiz.attributedString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
