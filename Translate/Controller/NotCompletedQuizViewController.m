//
//  NotCompletedQuizViewController.m
//  Translate
//
//  Created by willard on 2017/4/22.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "NotCompletedQuizViewController.h"
#import "WLQuiz+CoreDataClass.h"
#import "CompletedQuizViewController.h"
#import "WLTextView.h"
@interface NotCompletedQuizViewController ()

@end

@implementation NotCompletedQuizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _answerTextView = [[WLTextView alloc] init];
    _answerTextView.text = @"非常謝謝您，克里斯。可以有這個機會再度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的好評。";
    _answerTextView.editable = NO;
    _answerTextView.delegate = self;
    [self.view addSubview:_answerTextView];
    [self addAnswerTextViewConstraint];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Comfirm" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
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

- (void)save {
    [self.quiz submitWithUserAnswer:_answerTextView.text];
    CompletedQuizViewController *viewController = [[CompletedQuizViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.quiz = self.quiz;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)addAnswerTextViewConstraint {
    [_answerTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionTextView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];

}
@end
