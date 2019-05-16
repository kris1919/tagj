//
//  MyNotiManageViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "MyNotiManageViewController.h"
#import "UIColor+Theme.h"
#import "BillViewController.h"
#import "NotiViewController.h"
#import "MCNavigationBarView.h"
#import <Masonry.h>
#import "TKCycleData.h"
#import "MCNetworking.h"

@interface MyNotiManageViewController ()
@property (nonatomic ,strong)MCNavigationBarView *mc_navigationBar;

@end

@implementation MyNotiManageViewController

-(void)loadView{
    [super loadView];
    
    self.viewControllerClasses = @[[BillViewController class],[NotiViewController class]];
    self.titles = @[@"通知消息",@"平台消息"];
    self.menuItemWidth = kScreenWidth / 2;
    self.titleSizeNormal = 14;
    self.titleColorNormal = [UIColor labelColorLevel102];
    self.titleSizeSelected = 14;
    self.titleColorSelected = [UIColor colorWithR:15 G:115 B:238 A:1];//15, 115, 238, 1
    self.progressWidth = kScreenWidth / 2;
    self.progressHeight = 2;
    self.progressColor = [UIColor colorWithR:15 G:115 B:238 A:1];
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
    
    self.mc_navigationBar.title = @"我的消息";
    
    [self.mc_navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat x = [self statusBarHeight];
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(@(x+44));
    }];
    __weak __typeof(self) weakSelf = self;
    self.mc_navigationBar.backButtonHandle = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    [self requestData];
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

- (void)requestData{
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantNotiNumber];
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSDictionary *param = @{@"customId":userModel.customId};
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resultDic = [responseDic objectForKey:kTKResponseResultData];
        NSInteger num1 = [[resultDic objectForKey:@"num1"] integerValue];
        NSInteger num2 = [[resultDic objectForKey:@"num2"] integerValue];
        NSString *title1 = @"通知消息";
        NSString *title2 = @"平台消息";
        if (num1 != 0) {
            title1 = [NSString stringWithFormat:@"%@(%@)",title1,@(num1)];
        }
        if (num2 != 0) {
            title2 = [NSString stringWithFormat:@"%@(%@)",title2,@(num2)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.titles = @[title1,title2];
            [weakSelf.menuView reload];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
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
