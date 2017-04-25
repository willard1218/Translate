//
//  ViewController.h
//  Translate
//
//  Created by willard on 2017/3/18.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WLPanel.h"

@class WLQuiz;
@class WLTextView;
@class WLLabel;

@interface QuizViewController : UIViewController <UITextViewDelegate, WLPanelDelegate>
@property (weak, nonatomic) WLQuiz *quiz;
@property (nonatomic, strong) NSArray<WLPanel *> *panels;
@property (nonatomic, strong) WLPanel *questionPanel;
@property (nonatomic, strong) WLPanel *userAnswerPanel;
@property (nonatomic, strong) WLPanel *answerPanel;

@property (nonatomic, strong) WLLabel *questionTitleLabel;
@property (nonatomic, strong) WLTextView *questionTextView;
@end

