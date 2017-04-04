//
//  ArticleListTableViewController.m
//  Translate
//
//  Created by willard on 2017/4/4.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "ArticleListTableViewController.h"
#import "WLArticle+CoreDataClass.h"
#import "QuizListTableViewController.h"
@interface ArticleListTableViewController ()
@property NSMutableArray <WLArticle *> *articles;
@end

@implementation ArticleListTableViewController

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
                WLArticle *article = [WLArticle createEntityWithDict:dict];
                [_articles addObject:article];
                // [article save];;
            }
            
            [self.tableView reloadData];
        });
        
    }];
    [dataTask resume];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Article List";
    _articles = [NSMutableArray array];
    [self initArticles];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _articles[indexPath.row].title;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     QuizListTableViewController *quizListTableViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    quizListTableViewController.article = _articles[indexPath.row];
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
