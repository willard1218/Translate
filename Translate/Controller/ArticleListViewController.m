//
//  ArticleListViewController.m
//  Translate
//
//  Created by willard on 2017/4/10.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "ArticleListViewController.h"
#import "WLArticle+CoreDataClass.h"
#import "QuizListViewController.h"
#import "ArticleTableViewCell.h"
#import "SelectableTableView.h"


@interface ArticleListViewController ()

@property NSMutableArray <WLArticle *> *articles;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SelectableTableView *selectableTableView;
@end

@implementation ArticleListViewController


- (void)initArticles {
    NSString *baseURL = @"https://raw.githubusercontent.com/willard1218/Ted-subtitle-merge/master/";
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/tedInfos.json", baseURL];
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
        
        NSArray *articleDicts =
        [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (!articleDicts) {
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary *dict in articleDicts) {
                
                
                int16_t identifier = [dict[@"id"] intValue];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.identifier == %d", identifier];
                WLArticle *article = [WLArticle findFirstWithPredicate:predicate];
                
                if (!article) {
                    article = [WLArticle createEntityWithDict:dict];;
                    [article save];;
                }
                
                [_articles addObject:article];
            }
            
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
    [_tableView registerClass:ArticleTableViewCell.class];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Article List";
    _articles = [NSMutableArray array];
    [self initArticles];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithClass:ArticleTableViewCell.class forIndexPath:indexPath];
    
    cell.textLabel.text = _articles[indexPath.row].title;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuizListViewController *viewController = [[QuizListViewController alloc] init];
    viewController.article = _articles[indexPath.row];
    viewController.view.backgroundColor = [UIColor whiteColor];
 
    [self.navigationController pushViewController:viewController animated:YES];

}



@end
