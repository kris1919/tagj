//
//  TKTabBarController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKTabBarController.h"
#import "TKHomePageViewController.h"
#import "HouseKeeperViewController.h"
#import "NewPersonCenterViewController.h"
#import "NotificationViewController.h"
#import "TKBaseNavigationController.h"
#import "UIColor+Theme.h"

@interface TKTabBarController ()

@end

@implementation TKTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildViewControllers];
    
    self.selectedIndex = 0;
    
    [self setupTabBar];
    
}
- (void)setupTabBar{
    self.tabBar.backgroundImage = [self createImageWithColor:[UIColor clearColor]];
    self.tabBar.shadowImage = [self createImageWithColor:[UIColor clearColor]];
    self.tabBar.backgroundColor = [UIColor tableViewBgColor];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:backView.bounds];
    imageView.image = [UIImage imageNamed:@"icon_tab_bg"];
    [backView addSubview:imageView];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.translucent = YES;
}

-(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)addChildViewControllers{
    TKHomePageViewController *homeVC = [[TKHomePageViewController alloc] init];
    [self addChildViewController:homeVC title:@"首页" image:@"icon_tab_home_un" selectedImage:@"icon_tab_home"];
    
    HouseKeeperViewController *keeperVC = [[HouseKeeperViewController alloc] init];
    [self addChildViewController:keeperVC title:@"天安管家" image:@"icon_tab_keeper_un" selectedImage:@"icon_tab_keeper"];

    NotificationViewController *notiVC = [[NotificationViewController alloc] init];
    [self addChildViewController:notiVC title:@"小区公告" image:@"icon_tab_noti_un" selectedImage:@"icon_tab_noti"];

    NewPersonCenterViewController *mineVC = [[NewPersonCenterViewController alloc] init];
    [self addChildViewController:mineVC title:@"个人中心" image:@"icon_tab_person_un" selectedImage:@"icon_tab_person"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    childController.title = title;
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithR:196 G:196 B:196 A:1]} forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithR:33 G:120 B:255 A:1]} forState:UIControlStateSelected];
    TKBaseNavigationController *navi = [[TKBaseNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:navi];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
