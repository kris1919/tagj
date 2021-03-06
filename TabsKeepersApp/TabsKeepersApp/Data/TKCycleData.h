//
//  TKCycleData.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/11.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TKCycleData : NSObject

+ (instancetype)shareInstance;

@property (nonatomic ,strong ,nullable)TKUserModel *userModel;

@property (nonatomic ,copy)NSString *jpushRegisterId;

@end

NS_ASSUME_NONNULL_END
