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

@interface CompletedQuizViewController ()
@end

@implementation CompletedQuizViewController

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
    
    
    _diffWordsScrollableLabelView = [[ScrollableLabelView alloc] init];
    
    
    _diffWordsScrollableLabelView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_diffWordsScrollableLabelView];
    
    _noteView = [[NoteView alloc] init];
    _noteView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_noteView];

    
    
    _diffWordsScrollableLabelView.text = @"非常謝謝你，克里斯。能有這個機會第二度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的好評。非常謝謝你，克里斯。能有這個機會第二度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的好評。非常謝謝你，克里斯。能有這個機會第二度踏上這個演講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前演講的講台真是一大榮幸。我非常感激。這個研討會給我留下了極為深刻的印象，我想感謝大家對我之前 ";
    
    [self addDiffWordScrollableLabelConstraint];
    [self addNoteViewConstraint];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGSize size = _noteView.stackView.frame.size;
    _noteView.scrollView.contentSize = size;
}

- (void)addDiffWordScrollableLabelConstraint {
    [_diffWordsScrollableLabelView.topAnchor constraintEqualToAnchor:self.questionScrollableLabel.bottomAnchor constant:10].active = YES;
    
    [_diffWordsScrollableLabelView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10].active = YES;
    
    [_diffWordsScrollableLabelView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10].active = YES;
    
    [_diffWordsScrollableLabelView.heightAnchor constraintEqualToConstant:100].active = YES;
}

- (void)addNoteViewConstraint {
    _noteView.translatesAutoresizingMaskIntoConstraints = NO;
    [_noteView.topAnchor constraintEqualToAnchor:_diffWordsScrollableLabelView.bottomAnchor constant:10].active = YES;
    [_noteView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:10].active = YES;
    [_noteView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-10].active = YES;
    
    
    [_noteView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-10].active = YES;
    //[self.view layoutIfNeeded];
}

- (void)addNote {
    
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[notification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGSize keyboardSize = keyboardFrame.size;
    
  
    
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
