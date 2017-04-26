//
//  WLTextViewPanel.h
//  Translate
//
//  Created by willard on 2017/4/23.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLTextView;
@class WLPanel;

typedef NS_ENUM(NSInteger, WLPanelState) {
    WLPanelStateBlur,
    WLPanelStateFocus,
    WLPanelStateFocusout,
};

@protocol WLPanelDelegate <NSObject>
- (void)panel:(WLPanel *)panel didSelectButton:(UIButton *)button;
@end

@interface WLPanel : UIView
@property (nonatomic, weak) id <WLPanelDelegate> delegate;
@property (nonatomic, strong, readonly) NSString *selectedText;
@property (nonatomic, strong) WLTextView *textView;

@property (nonatomic, copy) NSString *titleTextWhenBlur;
@property (nonatomic, copy) NSString *titleTextWhenFocus;
@property (nonatomic, copy) NSString *buttonTextWhenFocus;
@property (nonatomic) WLPanelState state;
@end
