//
//  CompletedQuizViewController.m
//  ViewControllerDemo
//
//  Created by willard on 2017/4/12.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "CompletedQuizViewController.h"
#import "ScrollableLabelView.h"
#import "NoteView.h"
#import "WLQuiz+CoreDataClass.h"

@interface CompletedQuizViewController ()
@end

@implementation CompletedQuizViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)setup {
    [super setup];
    _diffWordsScrollableLabelView = [[ScrollableLabelView alloc] init];
    _noteView = [[NoteView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UIBarButtonItem *addNoteButton =
    [[UIBarButtonItem alloc] initWithTitle:@"Add Note"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(addNote)];
    
    self.title = @"Quiz";
    self.navigationItem.rightBarButtonItem = addNoteButton;
    
    
    
    
    [self.view addSubview:_diffWordsScrollableLabelView];
    
    _noteView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_noteView];

    
    
    [self addDiffWordScrollableLabelConstraint];
    [self addNoteViewConstraint];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGSize size = _noteView.stackView.frame.size;
    _noteView.scrollView.contentSize = size;
}

- (void)addDiffWordScrollableLabelConstraint {
    [_diffWordsScrollableLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.questionScrollableLabel.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@100);
    }];
}

- (void)addNoteViewConstraint {
    [_noteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.diffWordsScrollableLabelView.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.and.bottom.equalTo(self.view).offset(-10);
    }];
}

- (void)addNote {
    
    
}

- (void)setQuiz:(WLQuiz *)quiz {
    [super setQuiz:quiz];
    _diffWordsScrollableLabelView.attributedText = self.quiz.attributedString;
}


- (void)keyboardWillShow:(NSNotification *)notification {
  
    
    NSTimeInterval showDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:showDuration
                     animations:^{
                         self.view.frame =
                         CGRectMake(0, -30, self.view.frame.size.width, self.view.frame.size.height);
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval hideDuration = [[notification userInfo][UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:hideDuration
                     animations:^{
                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }];
}

@end
