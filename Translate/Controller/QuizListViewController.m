//
//  QuizListViewController.m
//  Translate
//
//  Created by willard on 2017/4/10.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "QuizListViewController.h"
#import "QuizViewController.h"
#import "WLArticle+CoreDataClass.h"
#import "WLQuiz+CoreDataClass.h"
#import "SelectableTableView.h"
#import "QuizTableViewCell.h"
#import "CompletedQuizViewController.h"
#import "NotCompletedQuizViewController.h"

@interface QuizListViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SelectableTableView *selectableTableView;

@end

@implementation QuizListViewController

- (void)fetchArticle {
    if (_article.quizs && _article.quizs.count > 0) {
        [self.tableView reloadData];
        return;
    }
    
    NSString *baseURL = @"https://raw.githubusercontent.com/willard1218/Ted-subtitle-merge/master/";
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/output/%d.json", baseURL, _article.identifier];
    NSURL *url = [NSURL URLWithString:urlString];
    
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        if (error) {
            return;
        }
        
        if ([data length] == 0) {
            return;
        }
        
        NSInteger statusCode = [((NSHTTPURLResponse *)response)statusCode];
        if (statusCode != 200) {
            return;
        }
        
        NSDictionary *articleDict =
        [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (!articleDict) {
            return;
        }
        
        [_article setupQuizsWithDictionary:articleDict];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    [dataTask resume];
}


- (void)loadView {
    _selectableTableView = [[SelectableTableView alloc] init];
    
    self.view = _selectableTableView;
    _tableView = _selectableTableView.tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:QuizTableViewCell.class];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.title = _article.title;
    [self fetchArticle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _article.quizs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuizTableViewCell *cell = [tableView dequeueReusableCellWithClass:QuizTableViewCell.class forIndexPath:indexPath];
    
    WLQuiz *quiz = _article.quizs[indexPath.row];
    cell.textLabel.text = quiz.question;
    NSUInteger wordCount = [quiz.question componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].count;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li", wordCount];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   CompletedQuizViewController *viewController = [[CompletedQuizViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.quiz = _article.quizs[indexPath.row];

    [self.navigationController pushViewController:viewController animated:YES];

}

@end
