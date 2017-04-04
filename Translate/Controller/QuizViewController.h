//
//  ViewController.h
//  Translate
//
//  Created by willard on 2017/3/18.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLQuiz;

@interface QuizViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) WLQuiz *quiz;

@end

