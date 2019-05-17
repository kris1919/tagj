//
//  TKHomePageViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/25.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKHomePageViewController.h"
#import "TKTableView.h"
#import "HomeHeaderCell.h"
#import "HomeNotificationCell.h"
#import "HomeAdvertiseCell.h"
#import <Masonry.h>
#import "TKCycleData.h"
#import "MCNetworking.h"
#import "HomeBannerModel.h"
#import "HomeAdModel.h"
#import <YYModel.h>
#import "ServiceProtocalViewController.h"
#import "HomeWaterFeeViewController.h"
#import "HomeWYFeeViewController.h"
#import "HomeServiceViewController.h"
#import "HomeShopViewController.h"
#import "HomeListenViewController.h"
#import "HomeParkViewController.h"
#import "NewRepaireViewController.h"
#import "TKRefreshFooter.h"

@interface TKHomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)NSMutableArray *bannerDataArr;
@property (nonatomic ,strong)NSMutableArray *bannerImages;
@property (nonatomic ,strong)NSMutableArray *adDataArr;
@property (nonatomic ,copy)NSString *notiStr;
@property (nonatomic ,assign)NSInteger currentPage;

@end

@implementation TKHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:249 green:249 blue:249 alpha:1.0];
    self.mc_navigationBar.alpha = 0;
    self.currentPage = 1;
    self.bannerDataArr = [NSMutableArray arrayWithCapacity:0];
    self.adDataArr = [NSMutableArray arrayWithCapacity:0];
    self.bannerImages = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, kTabBar_Height, 0));
    }];
    
    [self requestData];
    
    [self requstAdData];
    WS(weakSelf);
    self.tableView.mj_footer = [TKRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf requstAdData];
    }];
}
- (void)requstAdData{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantHomeAD];
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"page":@(self.currentPage)
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            HomeAdModel *model = [HomeAdModel yy_modelWithJSON:d];
            [weakSelf.adDataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    } showHUD:NO view:self.view];
}

- (void)requestData{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantHomeBanner];
    NSDictionary *param = @{@"customId":userModel.customId};
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            HomeBannerModel *model = [HomeBannerModel yy_modelWithJSON:d];
            [weakSelf.bannerDataArr addObject:model];
            [weakSelf.bannerImages addObject:model.img];
        }
        weakSelf.notiStr = [resDic objectForKey:@"title"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:NO view:self.view];
}
- (void)handleAction:(NSInteger)index{
    switch (index) {
        case 0:
        {
            HomeWaterFeeViewController *vc = [[HomeWaterFeeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            self.tabBarController.selectedIndex = 2;
        }
            break;
        case 2:
        {
            HomeParkViewController *vc = [[HomeParkViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            NewRepaireViewController *vc = [[NewRepaireViewController alloc] init];
            WS(weakSelf);
            vc.submitSuccessBlock = ^{
                weakSelf.tabBarController.selectedIndex = 1;
            };
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            HomeWYFeeViewController *vc = [[HomeWYFeeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            HomeServiceViewController *vc = [[HomeServiceViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            HomeListenViewController *vc = [[HomeListenViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            HomeShopViewController *vc = [[HomeShopViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)advertiseForIndex:(NSInteger)index{
    if (self.bannerDataArr.count <= index) {
        return;
    }
    HomeBannerModel *model = [self.bannerDataArr objectAtIndex:index];
    ServiceProtocalViewController *webVC = [[ServiceProtocalViewController alloc] init];
    webVC.urlStr = model.url;
    [self.navigationController pushViewController:webVC animated:YES];
}
#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section < 2 ? 1 : self.adDataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeHeaderCell"];
        if (!cell) {
            cell = [[HomeHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeHeaderCell"];
        }
        WS(weakSelf);
        cell.didSelectItemBlock = ^(NSInteger index) {
            [weakSelf handleAction:index];
        };
        cell.didSelectAdivertiseItemBlock = ^(NSInteger index) {
            [weakSelf advertiseForIndex:index];
        };
        cell.bannerImages = self.bannerImages;
        return cell;
    }else if (indexPath.section == 1){
        HomeNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNotificationCell" forIndexPath:indexPath];
        cell.notiLabel.text = self.notiStr;
        return cell;
    }else{
        HomeAdvertiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeAdvertiseCell" forIndexPath:indexPath];
        HomeAdModel *mdoel = [self.adDataArr objectAtIndex:indexPath.row];
        cell.model = mdoel;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 2) {
        return;
    }
    HomeAdModel *mdoel = [self.adDataArr objectAtIndex:indexPath.row];
    ServiceProtocalViewController *webVC = [[ServiceProtocalViewController alloc] init];
    webVC.mc_navigationBar.title = mdoel.title;
    webVC.urlStr = mdoel.url;
    [self.navigationController pushViewController:webVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return (269 + (kScreenWidth - 60) * 0.5) + (kIPhoneXSeries ? 24 : 0);
    if (indexPath.section == 1) return 46;
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? CGFLOAT_MIN : 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"HomeNotificationCell" bundle:nil] forCellReuseIdentifier:@"HomeNotificationCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"HomeAdvertiseCell" bundle:nil] forCellReuseIdentifier:@"HomeAdvertiseCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.bounces = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
