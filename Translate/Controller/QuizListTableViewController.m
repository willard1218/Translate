//
//  QuizListTableViewController.m
//  Translate
//
//  Created by willard on 2017/4/4.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "QuizListTableViewController.h"
#import "WLQuiz+CoreDataClass.h"
#import "WLArticle+CoreDataClass.h"
#import "QuizViewController.h"

@interface QuizListTableViewController ()

@end

@implementation QuizListTableViewController



- (void)fetchArticle {
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _article.title;
    [self fetchArticle];
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
    return _article.quizs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quizCell" forIndexPath:indexPath];
    
    cell.textLabel.text = _article.quizs[indexPath.row].question;

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
    QuizViewController *quizViewController = [segue destinationViewController];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    quizViewController.quiz = _article.quizs[indexPath.row];
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
