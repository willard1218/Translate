//
//  CompletedQuizViewController.m
//  ViewControllerDemo
//
//  Created by willard on 2017/4/12.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "CompletedQuizViewController.h"
#import "NoteView.h"
#import "WLQuiz+CoreDataClass.h"
#import "WLTextView.h"
@interface CompletedQuizViewController ()
@end

@implementation CompletedQuizViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)setup {
    [super setup];
    _userAnswerTextView = [[WLTextView alloc] init];
    _answerTextView = [[WLTextView alloc] init];
    _userAnswerTextView.editable = NO;
    _answerTextView.editable = NO;
    // _noteView = [[NoteView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIBarButtonItem *addNoteButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Add Note"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(addNote)];
    
    self.title = @"Quiz";
    self.navigationItem.rightBarButtonItem = addNoteButton;
    
    
    
    
    [self.view addSubview:_userAnswerTextView];
    [self.view addSubview:_answerTextView];
    _noteView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_noteView];

    
    
    [self addDiffWordTextViewConstraint];
    [self addNoteViewConstraint];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGSize size = _noteView.stackView.frame.size;
    _noteView.scrollView.contentSize = size;
}

- (void)addDiffWordTextViewConstraint {
    
    [_userAnswerTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionTextView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
    
    [_answerTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userAnswerTextView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
}

- (void)addNoteViewConstraint {
    [_noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userAnswerTextView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.and.bottom.equalTo(self.view).offset(-10);
    }];
}

- (void)addNote {
    
    
}

- (void)setQuiz:(WLQuiz *)quiz {
    [super setQuiz:quiz];
    _userAnswerTextView.attributedText = self.quiz.attributedUserAnswerString;
    _answerTextView.attributedText = self.quiz.attributedAnswerString;
}


@end
