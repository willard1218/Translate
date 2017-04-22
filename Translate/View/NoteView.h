//
//  NoteView.h
//  ViewControllerDemo
//
//  Created by willard on 2017/4/15.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteView : UIView
@property (nonatomic, strong) NSMutableArray <UITextView *> *textViews;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
