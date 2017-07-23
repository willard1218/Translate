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

@property (nonatomic, strong) NSMutableArray <WLArticle *> *displayArticles;
@property (nonatomic, strong) NSMutableArray <WLArticle *> *articles;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) SelectableTableView *selectableTableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic) NSInteger currentIdx;
@end

@implementation ArticleListViewController
const int kInterval = 20;

- (void)initArticles:(NSInteger)idx {
    NSString *baseURL = @"https://raw.githubusercontent.com/willard1218/Ted-subtitle-merge/master/infos";
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%ld.json", baseURL, idx];
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
            
            _displayArticles = _articles;
            [self hideActivityIndicatorView];
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
    _segmentedControl = _selectableTableView.segmentedControl;
    [_segmentedControl addTarget:self action:@selector(tabDidChange) forControlEvents:UIControlEventValueChanged];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Article List";
    _displayArticles = [NSMutableArray array];
    _articles = [NSMutableArray array];
    [self initArticles:_currentIdx];
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if (_activityIndicatorView) {
        return _activityIndicatorView;
    }
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] init];

    _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    return _activityIndicatorView;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _displayArticles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithClass:ArticleTableViewCell.class forIndexPath:indexPath];
    
    [cell setupDataWithArticle:_displayArticles[indexPath.row]];
    //cell.textLabel.text = _displayArticles[indexPath.row].title;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QuizListViewController *viewController = [[QuizListViewController alloc] init];
    viewController.article = _displayArticles[indexPath.row];
    viewController.view.backgroundColor = [UIColor whiteColor];
 
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)tabDidChange {
    TaskState taskState = _segmentedControl.selectedSegmentIndex;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.taskState == %d", taskState];
    NSArray *results = [_articles filteredArrayUsingPredicate:predicate];
    
    _displayArticles = results.copy;
    [_tableView reloadData];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate
{
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 30;
    if(y > h + reload_distance) {
        [self showActivityIndicatorView];
    }
}


- (void)showActivityIndicatorView {
    if (self.activityIndicatorView.superview) {
        return;
    }
    
    [self.view addSubview:self.activityIndicatorView];
    [_activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.centerX.equalTo(self.view);
        make.height.width.equalTo(@50);
    }];
    
    _currentIdx += kInterval;
    [self initArticles:_currentIdx];
    [_activityIndicatorView startAnimating];
    
}

- (void)hideActivityIndicatorView {
    [_activityIndicatorView stopAnimating];
    [_activityIndicatorView removeFromSuperview];
}

@end
