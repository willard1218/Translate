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

@interface QuizListViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) SelectableTableView *selectableTableView;
@property (nonatomic, strong) NSArray <WLQuiz *> *quizs;
@end

@implementation QuizListViewController

- (void)fetchArticle {
    if (_article.quizs && _article.quizs.count > 0) {
        _quizs = _article.quizs.array;
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
        _quizs = _article.quizs.array;
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
    
    _segmentedControl = _selectableTableView.segmentedControl;
    [_segmentedControl addTarget:self action:@selector(tabDidChange) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.title = _article.title;
    [self fetchArticle];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _quizs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuizTableViewCell *cell = [tableView dequeueReusableCellWithClass:QuizTableViewCell.class forIndexPath:indexPath];
    
    WLQuiz *quiz = _quizs[indexPath.row];
    [cell setupDataWithQuiz:quiz];
//    cell.textLabel.text = quiz.question;
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%li", wordCount];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuizViewController *viewController = [[QuizViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.quiz = _quizs[indexPath.row];

    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)tabDidChange {
    TaskState taskState = _segmentedControl.selectedSegmentIndex;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.taskStateRaw == %d", taskState];
    NSArray *results = [_article.quizs.array filteredArrayUsingPredicate:predicate];
    
    _quizs = results;
    [_tableView reloadData];
}
@end
