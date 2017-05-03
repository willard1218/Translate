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

@interface QuizViewController ()
@property (nonatomic) BOOL hasSubmited;
@property (nonatomic) TaskState state;
@end

@implementation QuizViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Quiz";
    [self setupViews];
    [self addViewConstraints];
   
}

- (void)setupViews {
    _questionPanel = [[WLPanel alloc] init];
    _answerPanel = [[WLPanel alloc] init];
    _userAnswerPanel = [[WLPanel alloc] init];
    
    _panels = @[_questionPanel, _userAnswerPanel, _answerPanel];
    NSArray *titleTextsWhenBlur = @[@"題目",
                                    @"答案",
                                    @"正確答案"];
    
    NSArray *titleTextsWhenFocus = @[@"請圈選翻錯的原句",
                                     @"請圈選你對這句的翻譯",
                                     @"請圈選這句正確的翻譯"];
    
    NSArray *buttonTextsWhenFocus = @[@"下一步",
                                      @"下一步",
                                      @"完成"];
    
    [_panels enumerateObjectsUsingBlock:^(WLPanel * _Nonnull panel, NSUInteger idx, BOOL * _Nonnull stop) {
        panel.titleTextWhenBlur = titleTextsWhenBlur[idx];
        panel.titleTextWhenFocus = titleTextsWhenFocus[idx];
        panel.buttonTextWhenFocus = buttonTextsWhenFocus[idx];
        panel.delegate = self;
        panel.state = WLPanelStateBlur;
        [self.view addSubview:panel];
    }];
    
    _noteListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_noteListButton];
    [self setNoteListButtonUI];
}

- (void)setNoteListButtonUI {
    [_noteListButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _noteListButton.layer.masksToBounds = YES;
    _noteListButton.layer.cornerRadius = 10;
    _noteListButton.layer.borderWidth = 1.0;
    _noteListButton.layer.borderColor = [UIColor blueColor].CGColor;
    _noteListButton.backgroundColor = [UIColor greenColor];
}

- (void)addViewConstraints {
    NSNumber *height = @120;
    CGFloat space = 10;
    CGFloat widthOffset = -30;
    
    [_questionPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(space);
        make.width.equalTo(self.view).offset(widthOffset);
        make.centerX.equalTo(self.view);
        make.height.equalTo(height);
    }];
 
    [_userAnswerPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_questionPanel.mas_bottom).offset(space);
        make.width.equalTo(self.view).offset(widthOffset);
        make.centerX.equalTo(self.view);
        make.height.equalTo(height);
    }];
    
    [_answerPanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_userAnswerPanel.mas_bottom).offset(space);
        make.width.equalTo(self.view).offset(widthOffset);
        make.centerX.equalTo(self.view);
        make.height.equalTo(height);
    }];
    
    [_noteListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@30);
    }];
}

#pragma mark Actions
- (void)setRightButtonWithTitle:(NSString *)title action:(SEL)action {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)saveButtonPressed {
    _quiz.taskState = TaskStateCompleted;
    _quiz.userAnswer = _userAnswerPanel.textView.text;
    self.hasSubmited = YES;
    [_quiz save];
}

- (void)addNoteButtonPressed {
    _questionPanel.state = WLPanelStateFocus;
}

#pragma mark Setters

- (void)setQuiz:(WLQuiz *)quiz {
    _quiz = quiz;
    _questionPanel.textView.text = _quiz.question;
    _questionPanel.textView.editable = NO;
    _answerPanel.textView.editable = NO;
    self.state = _quiz.taskState;
}


- (void)setState:(TaskState)state {
    switch (state) {
        case TaskStatePending:
        {
            _noteListButton.hidden = YES;
            _answerPanel.hidden = YES;
            [self setRightButtonWithTitle:@"Confirm" action:@selector(saveButtonPressed)];
            break;
        }
        case TaskStateExecuting:
        {
            _noteListButton.hidden = YES;
            _answerPanel.hidden = YES;
            [self setRightButtonWithTitle:@"Confirm" action:@selector(saveButtonPressed)];
            _userAnswerPanel.textView.text = _quiz.userAnswer;
            _answerPanel.hidden = YES;
            break;
        }
        case TaskStateCompleted:
        {
            _answerPanel.hidden = NO;
            _noteListButton.hidden = YES;
            
            [self setRightButtonWithTitle:@"Add Note" action:@selector(addNoteButtonPressed)];
       
          
            
            
            [self setNoteListButtonUI];
            
            _userAnswerPanel.textView.attributedText = _quiz.attributedUserAnswerString;
            
            _userAnswerPanel.textView.editable = NO;
            _answerPanel.textView.attributedText = _quiz.attributedAnswerString;
            
            NSUInteger numOfNotes = _quiz.notes.count;
            if (numOfNotes == 0) {
                break;
            }
            
            _noteListButton.hidden = NO;
            
            NSString *title = [NSString stringWithFormat:@"查看 %ld 則筆記", numOfNotes];
            [_noteListButton setTitle:title forState:UIControlStateNormal];
            break;
        }
    }
}

- (void)setHasSubmited:(BOOL)hasSubmited {
    _hasSubmited = hasSubmited;
      
    if (hasSubmited) {
        [_quiz submitWithUserAnswer:_userAnswerPanel.textView.text];
        self.state = TaskStateCompleted;
    }
}

#pragma mark Touch events

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (!_hasSubmited) {
        return [super canPerformAction:action withSender:sender];
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
    }];
    return [super canPerformAction:action withSender:sender];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [event.allTouches anyObject];
    
    if ([_userAnswerPanel.textView isFirstResponder] &&
        touch.view != _userAnswerPanel.textView) {
        [_userAnswerPanel.textView resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

#pragma mark Delegates
- (void)panel:(WLPanel *)panel didSelectButton:(UIButton *)button {
    for (NSUInteger i = 0; i < _panels.count; i++) {
        if (panel == _panels[i]) {
            panel.state = WLPanelStateFocusout;
            
            BOOL lastPanel = (i + 1 == _panels.count);
            if (lastPanel) {
                
                WLQuiz *quiz = [WLQuiz createEntityWithQuestion:_questionPanel.selectedText
                                                         answer:_answerPanel.selectedText
                                                     userAnswer:_userAnswerPanel.selectedText];
                [_quiz addNotesObject:quiz];
                [quiz save];
            }
            else {
                _panels[i + 1].state = WLPanelStateFocus;
            }
            
            break;
        }
    }
}

@end
