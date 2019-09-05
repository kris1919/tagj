//
//  NewRepaireViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/29.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NewRepaireViewController.h"
#import "TKTableView.h"
#import "NewRepairCell1.h"
#import "NewRepairCell2.h"
#import "NewRepairCell3.h"
#import <Masonry.h>
#import "TKTableViewFooterView.h"
#import "TKSelectedView.h"
#import <YYModel.h>
#import <HXPhotoPicker.h>
#import <UIViewController+HXExtension.h>
#import "MCNetworking.h"
#import "TKCycleData.h"
#import "MCHUD.h"
#import "ImageDisplayViewController.h"

@interface NewRepaireViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic ,strong)TKTableView *tableView;
@property (nonatomic ,strong)TKTableViewFooterView *footerView;
@property (nonatomic ,strong)TKSelectedView *selectView;
@property (nonatomic ,strong)KeyValueModel *selectedModel;
@property (nonatomic ,strong)NSArray *relationArr;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *phone;
@property (nonatomic ,copy)NSString *adress;
@property (nonatomic ,copy)NSString *describe;
@property (nonatomic ,copy)NSString *uploadImageUrls;
@property (nonatomic ,strong)NSMutableArray *pics;
@property (nonatomic ,strong)HXPhotoManager *photoManager;

@end

@implementation NewRepaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_navigationBar.title = @"业主报修";
    // Do any additional setup after loading the view.
    self.selectedModel = self.relationArr.firstObject;
    
    TKUserModel *userModel = [TKCycleData shareInstance].userModel;
    self.name = userModel.name;
    self.phone = userModel.phone;
    self.adress = userModel.address;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
    }];
    self.tableView.tableFooterView = self.footerView;
}

- (void)uploadImages{
    if (self.describe.length == 0) {
        [MCHUD showTips:@"请输入报修描述" view:self.view];
        return;
    }
    if (self.name.length == 0) {
        [MCHUD showTips:@"请输入联系人" view:self.view];
        return;
    }
    if (self.phone.length == 0) {
        [MCHUD showTips:@"请输入联系电话" view:self.view];
        return;
    }
    if (self.adress.length == 0) {
        [MCHUD showTips:@"请输入楼宇号" view:self.view];
        return;
    }
    dispatch_group_t group = dispatch_group_create();
    for (NSString *localPath in self.pics) {
        dispatch_group_enter(group);
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",kTKApiConstantDomin,kTKApiConstantUploadImg];
        UIImage *image = [UIImage imageWithContentsOfFile:localPath];
        NSData *data = UIImageJPEGRepresentation(image, 0.9);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        NSString *upSign = [encodedImageStr stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        NSDictionary *param = @{@"img":upSign};
        WS(weakSelf);
        [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
            NSDictionary *resDic = [responseDic objectForKey:kTKResponseResultData];
            NSString *imagePath = [resDic objectForKey:@"imgUrl"];
            if (weakSelf.uploadImageUrls.length == 0) {
                weakSelf.uploadImageUrls = imagePath;
            }else{
                weakSelf.uploadImageUrls = [weakSelf.uploadImageUrls stringByAppendingString:@","];
                weakSelf.uploadImageUrls = [weakSelf.uploadImageUrls stringByAppendingString:imagePath];
            }
            dispatch_group_leave(group);
        } failure:^(NSString * _Nonnull errorMsg) {
            dispatch_group_leave(group);
        } showHUD:YES view:self.view];
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",kTKApiConstantDomin,kTKApiConstantSubmitBaoXiu];
        TKUserModel *userModel = [TKCycleData shareInstance].userModel;
        NSDictionary *param = @{@"customId":userModel.customId,
                                @"type":self.selectedModel.code,
                                @"describe":self.describe,
                                @"imgList":(self.uploadImageUrls.length != 0) ? self.uploadImageUrls : @"",
                                @"name":self.name,
                                @"phone":self.phone,
                                @"hao":self.adress
                                };
        WS(weakSelf);
        [MCNetworking POSTWithUrl:urlStr parameter:param success:^(NSDictionary * _Nonnull responseDic) {
            [MCHUD showTips:@"提交成功" view:weakSelf.view];
            if (weakSelf.submitSuccessBlock) {
                weakSelf.submitSuccessBlock();
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString * _Nonnull errorMsg) {
            [MCHUD showTips:errorMsg view:weakSelf.view];
        } showHUD:YES view:self.view];
    });
}

- (void)submit{
    [self.view endEditing:YES];
    [self uploadImages];
}

#pragma mark - tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NewRepairCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRepairCell1" forIndexPath:indexPath];
        WS(weakSelf);
        cell.selectBtnClicked = ^{
            weakSelf.selectView.dataArr = weakSelf.relationArr;
            [weakSelf.view addSubview:weakSelf.selectView];
        };
        cell.textViewDidEndEditing = ^(NSString * _Nonnull text) {
            weakSelf.describe = text;
        };
        cell.selectStr = self.selectedModel.name;
        return cell;
    }else if (indexPath.section == 1){
        NewRepairCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRepairCell2" forIndexPath:indexPath];
        cell.canEditing = YES;
        WS(weakSelf);
        cell.selectedImg = ^(NSInteger index, BOOL show,UICollectionViewCell *collectCell) {
            if (show) {
                [weakSelf showImageWithIndex:index];
            }else{
                [weakSelf selectPic:collectCell];
            }
        };
        cell.deleteImg = ^(NSInteger index) {
            [weakSelf.pics removeObjectAtIndex:index];
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.imgs = self.pics;
        return cell;
    }else{
        NewRepairCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"NewRepairCell3" forIndexPath:indexPath];
        cell.nameStr = self.name;
        cell.phoneStr = self.phone;
        cell.addressStr = self.adress;
        WS(weakSelf);
        cell.textFieldDidEndEditing = ^(NSString * _Nonnull text, NSInteger tag) {
            if (0 == tag) {
                weakSelf.name = text;
            }else if (1 == tag){
                weakSelf.phone = text;
            }else if (2 == tag){
                weakSelf.adress = text;
            }
        };
        return cell;
    }
}

- (void)selectPic:(UICollectionViewCell *)cell{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        UIPopoverPresentationController *pop = [alertVC popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        pop.sourceView = cell;
        pop.sourceRect = cell.bounds;
    }
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self album];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self camera];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)album{
    self.photoManager.type = HXPhotoManagerSelectedTypePhoto;
    WS(weakSelf);
    [self hx_presentSelectPhotoControllerWithManager:self.photoManager didDone:^(NSArray<HXPhotoModel *> *allList, NSArray<HXPhotoModel *> *photoList, NSArray<HXPhotoModel *> *videoList, BOOL isOriginal, UIViewController *viewController, HXPhotoManager *manager) {
        for (HXPhotoModel *model in photoList) {
            [[PHImageManager defaultManager] requestImageDataForAsset:model.asset options:nil resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                // 直接得到最终的 NSData 数据
                [weakSelf saveImageToLocal:nil imageData:imageData];
            }];
        }
    } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
        
    }];
    [self.photoManager clearSelectedList];
}
- (void)camera{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)showImageWithIndex:(NSInteger)index{
    NSArray *photos = [IDMPhoto photosWithFilePaths:self.pics];
    ImageDisplayViewController *displayVC = [[ImageDisplayViewController alloc] initWithPhotos:photos];
    [displayVC setInitialPageIndex:index];
    [self presentViewController:displayVC animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 222;
    }
    if (indexPath.section == 1) {
        return (kScreenWidth - 32) / 4 + 50;
    }
    return 152;
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
        
        [_tableView registerNib:[UINib nibWithNibName:@"NewRepairCell1" bundle:nil] forCellReuseIdentifier:@"NewRepairCell1"];
        [_tableView registerClass:[NewRepairCell2 class] forCellReuseIdentifier:@"NewRepairCell2"];
        [_tableView registerNib:[UINib nibWithNibName:@"NewRepairCell3" bundle:nil] forCellReuseIdentifier:@"NewRepairCell3"];
        
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
        _footerView.btnTitle = @"提交申请";
        WS(weakSelf);
        _footerView.buttonActionBlock = ^(UIButton * _Nonnull btn) {
            [weakSelf submit];
        };
    }
    return _footerView;
}

-(TKSelectedView *)selectView{
    if (!_selectView) {
        CGFloat h = kNavigationBar_Height + 50;
        _selectView = [[TKSelectedView alloc] initWithFrame:CGRectMake(0, h, kScreenWidth, kScreenHeight - h)];
        WS(weakSelf);
        _selectView.selectedViewDidDoneBlock = ^(KeyValueModel * _Nonnull model) {
            weakSelf.selectedModel = model;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
            });
        };
    }
    return _selectView;
}
-(NSArray *)relationArr{
    if (!_relationArr) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        
        KeyValueModel *model = [[KeyValueModel alloc] init];
        model.code = @"1";
        model.name = @"室内报修";
        [arr addObject:model];
        
        KeyValueModel *model1 = [[KeyValueModel alloc] init];
        model1.code = @"2";
        model1.name = @"室外报修";
        [arr addObject:model1];
        _relationArr = arr.copy;
    }
    return _relationArr;
}

#pragma mark - UIImagePickerControllerDelegate
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImageToLocal:image imageData:nil];
}

- (void)saveImageToLocal:(UIImage *)image imageData:(NSData *)imageData2{
    NSData *imageData = imageData2 ? : UIImageJPEGRepresentation(image, 1);
    NSString *rootPath = [TKUtils pathForCache:kFilePathBaoXiuImagePath];
    NSString *path = [NSString stringWithFormat:@"%@/%@.jpeg",rootPath,[NSUUID UUID].UUIDString];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    BOOL rs = [imageData writeToFile:path atomically:YES];
    if (rs) {
        [self.pics addObject:path];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}
// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSMutableArray *)pics{
    if (!_pics) {
        _pics = [NSMutableArray arrayWithCapacity:0];
    }
    return _pics;
}
-(HXPhotoManager *)photoManager{
    if (!_photoManager) {
        _photoManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _photoManager.configuration.photoCanEdit = NO;
        _photoManager.configuration.showDateSectionHeader = NO;
        _photoManager.configuration.openCamera = NO;
        _photoManager.configuration.lookGifPhoto = NO;
        _photoManager.configuration.rowCount = 4;
        _photoManager.configuration.themeColor = [UIColor blueColor];
        _photoManager.configuration.hideOriginalBtn = YES;
        _photoManager.configuration.navigationBar = ^(UINavigationBar *navigationBar, UIViewController *viewController) {
            navigationBar.barTintColor = [UIColor whiteColor];
            navigationBar.tintColor = [UIColor blackColor];
        };
        self.photoManager.configuration.photoMaxNum = 3;
    }
    return _photoManager;
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
