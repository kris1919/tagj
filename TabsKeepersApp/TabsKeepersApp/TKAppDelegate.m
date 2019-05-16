//
//  AppDelegate.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKAppDelegate.h"
#import "TKBaseNavigationController.h"
#import "TKLoginViewController.h"
#import "TKTabBarController.h"
#import <IQKeyboardManager.h>

@interface TKAppDelegate ()

@end

@implementation TKAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [TKUserDefault setIsLogin:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessNoti) name:kNotificationLoginSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNoti) name:kNotificationLogout object:nil];

    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self setupRootVC];
    [self.window makeKeyAndVisible];
    
    [self config];
    return YES;
}
- (void)loginSuccessNoti{
    [TKUserDefault setIsLogin:YES];
    [self setupRootVC];
}
- (void)logoutNoti{
    [TKUserDefault setIsLogin:NO];
    [self setupRootVC];
}
- (void)setupRootVC{
    if (![TKUserDefault getIsLogin]) {
        TKLoginViewController *loginVC = [TKUtils viewControllerWithStory:@"Main" storyId:@"TKLoginViewController"];
        TKBaseNavigationController *navi = [[TKBaseNavigationController alloc] initWithRootViewController:loginVC];
        self.window.rootViewController = navi;
    }else{
        TKTabBarController *tabVC = [[TKTabBarController alloc] init];
        self.window.rootViewController = tabVC;
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)config{
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition]; //输入框自动上移
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}
@end
