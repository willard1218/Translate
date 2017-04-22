//
//  QuizListViewController.h
//  Translate
//
//  Created by willard on 2017/4/10.
//  Copyright © 2017年 willard. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLArticle;
@interface QuizListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) WLArticle *article;
@end
