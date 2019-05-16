//
//  MyFeeManageViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "MyFeeManageViewController.h"
#import "UIColor+Theme.h"
#import "WYFeeViewController.h"
#import "WaterFeeViewController.h"
#import "MCNavigationBarView.h"
#import <Masonry.h>

@interface MyFeeManageViewController ()
@property (nonatomic ,strong)MCNavigationBarView *mc_navigationBar;
@end

@implementation MyFeeManageViewController

-(void)loadView{
    [super loadView];
    
    self.viewControllerClasses = @[[WYFeeViewController class],[WaterFeeViewController class]];
    self.titles = @[@"物业费记录",@"水费记录"];
    self.menuItemWidth = kScreenWidth / 2;
    self.titleSizeNormal = 14;
    self.titleColorNormal = [UIColor labelColorLevel102];
    self.titleSizeSelected = 14;
    self.titleColorSelected = [UIColor redColor];
    self.progressWidth = kScreenWidth / 2;
    self.progressHeight = 2;
    self.progressColor = [UIColor colorWithR:37 G:129 B:255 A:1.0];
    self.menuViewStyle = WMMenuViewStyleLine;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 44 + [self statusBarHeight], kScreenWidth, 48);
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 48 + 44 + [self statusBarHeight], kScreenWidth, kScreenHeight - kNavigationBar_Height - 48);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mc_navigationBar.title = @"我的缴费记录";
    
    [self.mc_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat x = [self statusBarHeight];
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@(x+44));
    }];
    __weak __typeof(self) weakSelf = self;
    self.mc_navigationBar.backButtonHandle = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.menuView.backgroundColor = [UIColor whiteColor];
}

-(MCNavigationBarView *)mc_navigationBar{
    if (!_mc_navigationBar) {
        _mc_navigationBar = [[MCNavigationBarView alloc] init];
        [self.view addSubview:_mc_navigationBar];
    }
    return _mc_navigationBar;
}

- (CGFloat)statusBarHeight{
    return kIPhoneXSeries ? 44 : 20;
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
