//
//  RepairedViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "RepairedViewController.h"
#import "TKTableView.h"
#import "NewRepairCell2.h"
#import <Masonry.h>
#import "TKTableViewFooterView.h"
#import "TKKeyValueModel.h"
#import "TKDoubleLabelCell.h"
#import "TKCycleData.h"
#import "MCNetworking.h"
#import <YYModel.h>
#import "ImageDisplayViewController.h"

@implementation RepairDetailModel

@end

@interface RepairedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)TKTableViewFooterView *footerView;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong)RepairDetailModel *detailModel;

@end

@implementation RepairedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.title = @"业主报修";
    // Do any additional setup after loading the view.
    
    [self setupData];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
    }];
    
    [self requestData];
}

- (void)setCanEvaluate:(BOOL)canEvaluate{
    if (canEvaluate) {
//        self.tableView.tableFooterView = self.footerView;
    }
}

- (void)requestData{
    if (self.baoxiuId.length == 0) {
        return;
    }
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    NSString *urlStr =[kTKApiConstantDomin stringByAppendingString:kTKApiConstantBaoxiuDetail];
    NSDictionary *param = @{@"customId":userModel.customId,
                            @"id":self.baoxiuId,
                            };
    WS(weakSelf);
    [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
        NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
        weakSelf.detailModel = [RepairDetailModel yy_modelWithJSON:resDic];
        [weakSelf setupData];
    } failure:^(NSString * _Nonnull errorMsg) {
        
    } showHUD:YES view:self.view];
}

- (void)setupData{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    TKKeyValueModel *model1 = [[TKKeyValueModel alloc] initWithKey:@"报修类别:" value:self.detailModel.type.integerValue == 2 ? @"室外报修": @"室内报修"];
    TKKeyValueModel *model2 = [[TKKeyValueModel alloc] initWithKey:@"报修描述:" value:self.detailModel.describe];
    TKKeyValueModel *model3 = [[TKKeyValueModel alloc] initWithKey:@"图片附件:" value:@"无"];
    TKKeyValueModel *model4 = [[TKKeyValueModel alloc] initWithKey:@"联系人:" value:self.detailModel.name];
    TKKeyValueModel *model5 = [[TKKeyValueModel alloc] initWithKey:@"联系电话:" value:self.detailModel.phone];
    TKKeyValueModel *model6 = [[TKKeyValueModel alloc] initWithKey:@"楼宇号:" value:self.detailModel.hao];
    [self.dataArr addObjectsFromArray:@[model1,model2,model3,model4,model5,model6]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2 && self.detailModel.imgList.count > 0) {
        NewRepairCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRepairCell2" forIndexPath:indexPath];
        cell.imgs = self.detailModel.imgList;
        WS(weakSelf);
        cell.selectedImg = ^(NSInteger index, BOOL show) {
            [weakSelf displayImageWithIndex:index];
        };
        return cell;
    }else{
        TKDoubleLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TKDoubleLabelCell" forIndexPath:indexPath];
        TKKeyValueModel *model = [self.dataArr objectAtIndex:indexPath.row];
        cell.keyString = model.key;
        cell.valueString = model.value;
        return cell;
    }
}
- (void)displayImageWithIndex:(NSInteger)index{
    NSArray *photos = [IDMPhoto photosWithURLs:self.detailModel.imgList];
    ImageDisplayViewController *displayVC = [[ImageDisplayViewController alloc] initWithPhotos:photos];
    [displayVC setInitialPageIndex:index];
    [self presentViewController:displayVC animated:YES completion:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2 && self.detailModel.imgList.count > 0) {
        return 126;
    }
    tableView.estimatedRowHeight = 60;
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
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
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        
        [_tableView registerClass:[NewRepairCell2 class] forCellReuseIdentifier:@"NewRepairCell2"];
        [_tableView registerClass:[TKDoubleLabelCell class] forCellReuseIdentifier:@"TKDoubleLabelCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        tap.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:tap];
    }
    return _tableView;
}

- (void)tap{
    [self.view endEditing:YES];
}


-(TKTableViewFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[TKTableViewFooterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        _footerView.imageName = @"icon_evaluate_submit";
        _footerView.btnTitle = @"评价";
        _footerView.buttonActionBlock = ^(UIButton * _Nonnull btn) {
            
        };
    }
    return _footerView;
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
