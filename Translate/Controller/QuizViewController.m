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
@end

@implementation QuizViewController

- (void)setup {
    [super setup];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Comfirm" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonPressed)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Quiz";
    _questionPanel = [[WLPanel alloc] init];
    _answerPanel = [[WLPanel alloc] init];
    _userAnswerPanel = [[WLPanel alloc] init];
    
    _panels = @[_questionPanel, _userAnswerPanel, _answerPanel];
    
    _questionPanel.delegate = self;
    _answerPanel.delegate = self;
    _userAnswerPanel.delegate = self;
    
    
    
    _questionPanel.textView.delegate = self;
    _userAnswerPanel.textView.delegate = self;
    _answerPanel.textView.delegate = self;
    
    _questionPanel.titleTextWhenBlur = @"題目";
    _userAnswerPanel.titleTextWhenBlur = @"答案";
    _answerPanel.titleTextWhenBlur = @"正確答案";
    
    _questionPanel.titleTextWhenFocus = @"請圈選翻錯的原句";
    _userAnswerPanel.titleTextWhenFocus = @"請圈選你對這句的翻譯";
    _answerPanel.titleTextWhenFocus = @"請圈選這句正確的翻譯";
    
    _questionPanel.buttonTextWhenFocus = @"下一步";
    _userAnswerPanel.buttonTextWhenFocus = @"下一步";
    _answerPanel.buttonTextWhenFocus = @"完成";
    
    _questionPanel.state = WLPanelStateBlur;
    _userAnswerPanel.state = WLPanelStateBlur;
    _answerPanel.state = WLPanelStateBlur;
    
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
}

- (void)setQuiz:(WLQuiz *)quiz {
    _quiz = quiz;
    _questionPanel.textView.text = quiz.question;
}

- (void)saveButtonPressed {
    self.hasSubmited = YES;
}

- (void)addNoteButtonPressed {
    _questionPanel.state = WLPanelStateFocus;
}

- (void)selectTextWithRange:(NSRange)range inTextView:(UITextView *)textView {
    textView.selectedRange = range;
    [textView select:self];
    [textView setContentOffset:CGPointZero animated:YES];
}

- (void)setHasSubmited:(BOOL)hasSubmited {
    _hasSubmited = hasSubmited;
    
    if (hasSubmited) {
        [_quiz submitWithUserAnswer:_userAnswerPanel.textView.text];
        _userAnswerPanel.textView.text = nil;
        _userAnswerPanel.textView.attributedText = _quiz.attributedUserAnswerString;
        
        _userAnswerPanel.textView.editable = NO;
        _answerPanel.textView.attributedText = _quiz.attributedAnswerString;
        _answerPanel.hidden = NO;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Note" style:UIBarButtonItemStylePlain target:self action:@selector(addNoteButtonPressed)];
        self.navigationItem.rightBarButtonItem = barButtonItem;
        
    }
}

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

- (void)panel:(WLPanel *)panel didSelectButton:(UIButton *)button {
    for (NSUInteger i = 0; i < _panels.count; i++) {
        if (panel == _panels[i]) {
            panel.state = WLPanelStateFocusout;
            
            if (i + 1 < _panels.count) {
                _panels[i + 1].state = WLPanelStateFocus;
            }
            
            break;
        }
    }
}

@end
