//
//  UILabel+Utility.h
//  ViewControllerDemo
//
//  Created by willard on 2017/4/14.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UILabel (Utility)
- (CGFloat)textHeight;
- (CGFloat)textHeightForWidth:(CGFloat)width;
- (CGFloat)attributedTextHeightForWidth:(CGFloat)width;
@end

@interface NSString (Utility)
- (CGFloat)heightForWidth:(CGFloat)width font:(UIFont *)font;
@end

@interface NSAttributedString (Utility)
- (CGFloat)heightForWidth:(CGFloat)width;
@end
