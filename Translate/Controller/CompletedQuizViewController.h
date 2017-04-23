//
//  CompletedQuizViewController.h
//  ViewControllerDemo
//
//  Created by willard on 2017/4/12.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "QuizViewController.h"
@class WLTextView;
@class NoteView;
@interface CompletedQuizViewController : QuizViewController
@property (nonatomic, strong) WLTextView *diffWordsTextView;
@property (nonatomic, strong) NoteView *noteView;
@end
