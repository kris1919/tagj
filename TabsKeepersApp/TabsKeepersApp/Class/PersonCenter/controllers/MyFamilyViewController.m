//
//  MyFamilyViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "MyFamilyViewController.h"
#import "TKTableView.h"
#import "FamilyTableViewCell.h"
#import <Masonry.h>
#import "BottomView.h"
#import "AddFamilyViewController.h"
#import "TKCycleData.h"
#import "MCNetworking.h"
#import "MyFamilyListModel.h"
#import <YYModel.h>
#import "TKRefreshHeader.h"
#import "TKRefreshFooter.h"

@interface MyFamilyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)BottomView *bottomView;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,assign)NSInteger currentPage;

@end

@implementation MyFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.currentPage = 1;
    // Do any additional setup after loading the view.
    self.mc_navigationBar.title = @"我的家人";
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
    }];
    self.bottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    self.tableView.tableFooterView = self.bottomView;
    WS(weakSelf);
    self.bottomView.clickHandler = ^{
        AddFamilyViewController *addVC = [TKUtils viewControllerWithStory:@"Main" storyId:@"AddFamilyViewController"];
        addVC.didAddNewFamilyMemberBlock = ^{
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [weakSelf.navigationController pushViewController:addVC animated:YES];
    };
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

- (void)requestData{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"page":@(self.currentPage)
                            };
    NSString *urlStr = [kTKApiConstantDomin stringByAppendingString:kTKApiConstantPersonalMyFamily];
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *dataDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [dataDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            MyFamilyListModel *model = [MyFamilyListModel yy_modelWithJSON:d];
            [weakSelf.dataArr addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
            [weakSelf.tableView reloadData];
        });
    } failure:^(NSString * _Nonnull errorMsg) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } showHUD:NO view:self.view];
}
#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FamilyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FamilyTableViewCell" forIndexPath:indexPath];
    cell.model = [self.dataArr objectAtIndex:indexPath.section];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 5 : CGFLOAT_MIN;
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
        
        [_tableView registerNib:[UINib nibWithNibName:@"FamilyTableViewCell" bundle:nil] forCellReuseIdentifier:@"FamilyTableViewCell"];
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
