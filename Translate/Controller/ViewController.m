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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"2403" ofType:@"txt"];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *articleDict =
    [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    WLArticle *article = [WLArticle createEntityWithDict:articleDict];
    WLQuiz *quiz = article.quizs[0];
    
    [quiz submitWithUserAnswer:@"Roy Price這，個位可能沒有聽過，即使他曾經負責過你生命中平凡無奇的22分鐘，在2013年4月19日這一天。他也許也曾負責帶給各位非常歡樂的22分鐘，但你們其中也許很多人並沒有。而這一切全部要回到Roy在三"];
    
    
    _questionLabel.attributedText = quiz.attributedString;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
