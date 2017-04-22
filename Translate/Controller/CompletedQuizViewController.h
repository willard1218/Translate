//
//  CompletedQuizViewController.h
//  ViewControllerDemo
//
//  Created by willard on 2017/4/12.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "QuizViewController.h"
@class ScrollableLabelView;
@class NoteView;
@interface CompletedQuizViewController : QuizViewController
@property (nonatomic, strong) ScrollableLabelView *diffWordsScrollableLabelView;
@property (nonatomic, strong) NoteView *noteView;
@end
