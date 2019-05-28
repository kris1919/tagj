//
//  HouseKeeperViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "HouseKeeperViewController.h"
#import "NewRepaireViewController.h"
#import "TKTableView.h"
#import "HouseKeeperViewCell.h"
#import <Masonry.h>
#import "TKEvaluateView.h"
#import "RepairedViewController.h"
#import "TKRefreshHeader.h"
#import "TKRefreshFooter.h"
#import "TKCycleData.h"
#import "MCNetworking.h"
#import <YYModel.h>
#import "BaoxiuModel.h"
#import "MCHUD.h"

@interface HouseKeeperViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,assign)NSInteger currentPage;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,copy)NSString *pjLevel;
@property (nonatomic ,copy)NSString *pjContent;
@property (nonatomic ,strong)TKEvaluateView *evaluateView;


@end

@implementation HouseKeeperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mc_navigationBar.title = @"天安管家";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.currentPage = 1;
    self.pjLevel = @"1";
    WS(weakSelf);
    [self.mc_navigationBar addRightBarItemWithImage:[UIImage imageNamed:@"icon_add"] handle:^{
        NewRepaireViewController *repairVC = [[NewRepaireViewController alloc] init];
        repairVC.submitSuccessBlock = ^{
            [weakSelf.tableView.mj_header beginRefreshing];
        };
        [weakSelf.navigationController pushViewController:repairVC animated:YES];
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, kTabBar_Height, 0));
    }];

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

//- (NSArray *)testaa{
//    return  @[@{
//        @"id": @"1",
//        @"pudate": @"2018-07-15",
//        @"zt": @"1",
//        @"pjZt": @"1",
//        @"describe": @"我家的房顶漏水"
//    },
//     @{
//         @"id": @"1",
//         @"pudate": @"2018-07-15",
//         @"zt": @"2",
//         @"pjZt": @"2",
//         @"describe": @"我家的房顶漏水"
//     }
//              ];
//}

- (void)addPj:(NSInteger)index{
    [self.view endEditing:YES];
    if (self.pjLevel.length == 0) {
        [MCHUD showTips:@"请选择评价等级" view:self.view];
        return;
    }
    if (self.pjContent.length == 0) {
        [MCHUD showTips:@"请输入评价内容" view:self.view];
        return;
    }
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantAddEvaluate];
    BaoxiuModel *model = [self.dataArr objectAtIndex:index];
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"id":model.bxid,
                            @"pjDj":self.pjLevel,
                            @"memo":self.pjContent
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        [weakSelf.evaluateView tk_hidden];
        [weakSelf.tableView reloadData];
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
}
- (void)chexiao:(NSInteger)index{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantDeleteBaoxiu];
    BaoxiuModel *model = [self.dataArr objectAtIndex:index];
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"id":model.bxid
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        [weakSelf.tableView reloadData];
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
    
}

- (void)shouldChexiao:(NSInteger)index{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否要撤销报修？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chexiao:index];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)requestData{
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantHKList];
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"page":@(self.currentPage)
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        NSArray *listArr = [resDic objectForKey:@"list"];
        for (NSDictionary *d in listArr) {
            BaoxiuModel *model = [BaoxiuModel yy_modelWithJSON:d];
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
    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HouseKeeperViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouseKeeperViewCell" forIndexPath:indexPath];
    BaoxiuModel *model = [self.dataArr objectAtIndex:indexPath.section];
    cell.model = model;
    WS(weakSelf);
    cell.operBtnHandleBlock = ^(NSInteger type,NSInteger index){
        if (type == 1) {//撤销
            [weakSelf shouldChexiao:index];
        }else if (type == 2){//评价
            self.evaluateView.submitBlock = ^{
                [weakSelf addPj:index];
            };
            self.evaluateView.evaluateBlock = ^(NSInteger level) {
                weakSelf.pjLevel = [NSString stringWithFormat:@"%@",@(level)];
            };
            self.evaluateView.textViewEndEditingBlock = ^(NSString * _Nonnull text) {
                weakSelf.pjContent = text;
            };
            [self.evaluateView show];
        }
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 196;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
    RepairedViewController *repairedVC = [[RepairedViewController alloc] init];
    BaoxiuModel *model = [self.dataArr objectAtIndex:indexPath.section];
    repairedVC.baoxiuId = model.bxid;
    repairedVC.canEvaluate = (model.zt.integerValue == 3 && model.pjZt.integerValue == 1);
    [self.navigationController pushViewController:repairedVC animated:YES];
}

-(TKTableView *)tableView{
    if (!_tableView) {
        _tableView = [[TKTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerNib:[UINib nibWithNibName:@"HouseKeeperViewCell" bundle:nil] forCellReuseIdentifier:@"HouseKeeperViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(TKEvaluateView *)evaluateView{
    if (!_evaluateView) {
        _evaluateView = (TKEvaluateView *)[TKUtils nibWithNibName:@"TKEvaluateView"];
    }
    return _evaluateView;
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
