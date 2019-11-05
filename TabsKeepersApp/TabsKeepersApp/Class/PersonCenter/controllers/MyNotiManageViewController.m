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
@property (nonatomic ,assign)NSInteger billNotiNo;
@property (nonatomic ,assign)NSInteger platformNotiNo;
@property (nonatomic ,copy)NSString *title1;
@property (nonatomic ,copy)NSString *title2;
@end

@implementation MyNotiManageViewController

-(void)loadView{
    [super loadView];
    self.title1 = @"通知消息";
    self.title2 = @"平台消息";
    self.viewControllerClasses = @[[BillViewController class],[NotiViewController class]];
    self.titles = @[self.title1,self.title2];
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
        weakSelf.billNotiNo = [[resultDic objectForKey:@"num1"] integerValue];
        weakSelf.platformNotiNo = [[resultDic objectForKey:@"num2"] integerValue];
        [weakSelf reloadHeaderIndex:0];
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
}

-(void)pageController:(WMPageController *)pageController lazyLoadViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    if ([viewController isKindOfClass:[BillViewController class]]) {
        BillViewController *vc = viewController;
        WS(weakSelf);
        vc.notiDidReadBlock = ^{
            weakSelf.billNotiNo--;
            weakSelf.billNotiNo = weakSelf.billNotiNo > 0 ? weakSelf.billNotiNo : 0;
            [weakSelf reloadHeaderIndex:1];
            weakSelf.selectIndex = 0;
        };
    }else if ([viewController isKindOfClass:[NotiViewController class]]){
        NotiViewController *vc = viewController;
        WS(weakSelf);
        vc.notiDidReadBlock = ^{
            weakSelf.platformNotiNo--;
            weakSelf.platformNotiNo = weakSelf.platformNotiNo > 0 ? weakSelf.platformNotiNo : 0;
            [weakSelf reloadHeaderIndex:2];
            weakSelf.selectIndex = 1;
        };
    }
}

- (void)reloadHeaderIndex:(int)index{
    NSString *title1 = self.title1;
    NSString *title2 = self.title2;
    if (self.billNotiNo != 0) {
        title1 = [NSString stringWithFormat:@"%@(%@)",self.title1,@(self.billNotiNo)];
    }
    if (self.platformNotiNo != 0) {
        title2 = [NSString stringWithFormat:@"%@(%@)",self.title2,@(self.platformNotiNo)];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titles = @[title1,title2];
        if (index == 0) {//刷新全部
            [self.menuView reload];
        }else{
            //1:通知消息  2：平台消息
            [self.menuView updateTitle:index == 1 ? title1 : title2 atIndex:index - 1 andWidth:NO];
        }
    });
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
