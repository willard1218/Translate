//
//  AppDelegate.m
//  Translate
//
//  Created by willard on 2017/3/18.
//  Copyright © 2017年 willard. All rights reserved.
//

#import "AppDelegate.h"
#import "ArticleListViewController.h"
#import "WLDashboardViewController.h"
#import "WLSettingViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect rect = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:rect];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    NSMutableArray *navigationControllers = [NSMutableArray array];
    
    {
        ArticleListViewController *viewController = [[ArticleListViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.navigationBar.translucent = NO;
        navigationController.tabBarItem.image = [UIImage imageNamed:@"icons8-question_group"];
        [navigationControllers addObject:navigationController];
    }
    
    
    {
        WLDashboardViewController *viewController = [[WLDashboardViewController alloc] init];
        viewController.title = @"Dashboard";
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.navigationBar.translucent = NO;
        navigationController.tabBarItem.image = [UIImage imageNamed:@"icons8-long_position"];
        [navigationControllers addObject:navigationController];
    }
    
    {
        WLSettingViewController *viewController = [[WLSettingViewController alloc] init];
        viewController.title = @"Setting";
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        navigationController.navigationBar.translucent = NO;
        navigationController.tabBarItem.image = [UIImage imageNamed:@"icons8-settings"];
        [navigationControllers addObject:navigationController];
    }
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = navigationControllers;

    
    self.window.rootViewController = tabBarController;
    
    return YES;
}


@end
