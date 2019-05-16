//
//  NotificationViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NotificationViewController.h"
#import "TKTableView.h"
#import <Masonry.h>
#import "NotificationListCell.h"
#import "UIColor+Theme.h"
#import "TKRefreshHeader.h"
#import "TKRefreshFooter.h"
#import "TKCycleData.h"
#import "MCNetworking.h"
#import <YYModel.h>
#import "HouseNotificationModel.h"
#import "ServiceProtocalViewController.h"

@interface NotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,assign)NSInteger currentPage;
@property (nonatomic ,strong)NSMutableArray *dataArr;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.title = @"小区公告";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.currentPage = 1;
    // Do any additional setup after loading the view.
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, kTabBar_Height, 0));
    }];
    WS(weakSelf);
    self.tableView.mj_header = [TKRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        [weakSelf.dataArr removeAllObjects];
        [weakSelf requestData];
    }];
    self.tableView.mj_footer = [TKRefreshFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf requestData];
    }];
    
    [self.tableView.mj_header beginRefreshing];
}

//- (NSArray *)testArr{
//    return @[@{
//        @"newsId": @"1",
//        @"title": @"物业缴费通知",
//        @"img": @"http://wuye.gugangkf.cn/Upload/1.jpg",
//        @"zuozhe": @"物业管理处",
//        @"pudate": @"2019-01-05 15:47:25",
//        @"url": @"http://wuye.gugangkf.cn/json/news.aspx?id=1"
//    },
//            @{
//                @"newsId": @"2",
//                @"title": @"小区防火注意事项",
//                @"img": @"http://wuye.gugangkf.cn/Upload/2.jpg",
//                @"zuozhe": @"物业管理处",
//                @"pudate": @"2019-01-05 15:47:25",
//                @"url": @"http://wuye.gugangkf.cn/json/news.aspx?id=2"
//            }
//             ];
//}

- (void)requestData{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantNotification];
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"page":@(self.currentPage)
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            HouseNotificationModel *model = [HouseNotificationModel yy_modelWithJSON:d];
            [weakSelf.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    } showHUD:NO view:self.view];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationListCell" forIndexPath:indexPath];
    HouseNotificationModel *model = [self.dataArr objectAtIndex:indexPath.section];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 10 : CGFLOAT_MIN;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceProtocalViewController *pageVC = [[ServiceProtocalViewController alloc] init];
    HouseNotificationModel *model = [self.dataArr objectAtIndex:indexPath.section];
    pageVC.urlStr = model.url;
    pageVC.mc_navigationBar.title = @"小区公告";
    [self.navigationController pushViewController:pageVC animated:YES];
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"NotificationListCell" bundle:nil] forCellReuseIdentifier:@"NotificationListCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
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
