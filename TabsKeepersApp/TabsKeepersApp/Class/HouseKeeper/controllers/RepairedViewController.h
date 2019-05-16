//
//  RepairedViewController.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/3.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKBaseViewController.h"


@interface RepairDetailModel : NSObject
@property (nonatomic ,copy)NSString *pudate;
@property (nonatomic ,copy)NSString *zt;
@property (nonatomic ,copy)NSString *pjZt;
@property (nonatomic ,copy)NSString *describe;
@property (nonatomic ,copy)NSString *type;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *phone;
@property (nonatomic ,copy)NSString *hao;
@property (nonatomic ,strong)NSMutableArray *imgList;
@end

NS_ASSUME_NONNULL_BEGIN

@interface RepairedViewController : TKBaseViewController

@property (nonatomic ,copy)NSString *baoxiuId;

@property (nonatomic ,assign)BOOL canEvaluate;

@end

NS_ASSUME_NONNULL_END
