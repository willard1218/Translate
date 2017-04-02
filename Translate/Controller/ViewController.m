//
//  ViewController.m
//  Translate
//
//  Created by willard on 2017/3/18.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "ViewController.h"
#import "WLArticle+CoreDataClass.h"
#import "WLQuiz+CoreDataClass.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *diffWordsLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;
@property (strong, nonatomic) WLQuiz *quiz;
@end

@implementation ViewController
- (void)initFakeData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"2403" ofType:@"txt"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *articleDict =
    [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    WLArticle *article = [WLArticle createEntityWithDict:articleDict];
    _quiz = article.quizs[0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initFakeData];
    _questionLabel.text = _quiz.question;
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
