//
//  WLTextViewPanel.m
//  Translate
//
//  Created by willard on 2017/4/23.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "WLPanel.h"
#import "WLTextView.h"
@interface WLPanel()
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *button;
@end

@implementation WLPanel

- (void)setup {
    [super setup];
    _textView = [[WLTextView alloc] init];
    _titleView = [[UIView alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    
    [_button addTarget:self action:@selector(confrimButtonPressed:) forControlEvents:UIControlEventTouchDown];
    _button.hidden = YES;
    _button.titleLabel.font = [UIFont systemFontOfSize:18];
    
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor blueColor];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self addSubview:_titleView];
    [_titleView addSubview:_titleLabel];
    [self addSubview:_textView];
    [self addSubview:_button];
    [self addViewConstraints];
}

- (void)addViewConstraints {
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.height.equalTo(@20);
        make.right.equalTo(self).offset(-50);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_titleView);
        make.width.equalTo(_titleView);
        // make.width.equalTo(@100);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom).offset(3);
        make.left.right.equalTo(self);
        make.height.equalTo(@80);
    }];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.mas_bottom).offset(5);
        make.right.width.equalTo(self);
        make.bottom.equalTo(self);
        //make.height.equalTo(@30);
    }];
}

- (void)confrimButtonPressed:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(panel:didSelectButton:)]) {
        [self.delegate panel:self didSelectButton:button];
    }
}

- (void)setState:(WLPanelState)state {
    switch (state) {
        case WLPanelStateBlur:
            _titleLabel.text = _titleTextWhenBlur;
            _button.hidden = YES;
            break;
        case WLPanelStateFocus:
            [_button setTitle:_buttonTextWhenFocus forState:UIControlStateNormal];
            
            _titleLabel.text = _titleTextWhenFocus;
            _button.hidden = NO;
            [self selectText];
            break;
        case WLPanelStateFocusout:
        {
            UITextRange *selectedRange = [_textView selectedTextRange];
            _selectedText = [_textView textInRange:selectedRange];
            
            _titleLabel.text = _titleTextWhenBlur;
            _button.hidden = YES;
            [self deselectText];
            break;
        }
    }
    
}

- (void)deselectText {
    [self deselectTextWithTextView:_textView];
}

- (void)deselectTextWithTextView:(UITextView *)textView {
    textView.selectedTextRange = nil;
}

- (void)selectText {
    [self selectTextWithTextView:_textView];
}

- (void)selectTextWithTextView:(UITextView *)textView {
    NSRange range = NSMakeRange(0, 10);
    [self selectTextWithRange:range inTextView:textView];
}

- (void)selectTextWithRange:(NSRange)range inTextView:(UITextView *)textView {
    [textView select:self];
    textView.selectedRange = range;
    [textView setContentOffset:CGPointZero animated:YES];
}
@end
