//
//  TKCycleData.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/11.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKCycleData.h"
#import "TKUserDefault.h"
#import <YYModel.h>

@implementation TKCycleData

+(instancetype)shareInstance{
    static TKCycleData *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TKCycleData alloc] init];
    });
    return _instance;
}

- (TKUserModel *)userModel{
    if (!_userModel) {
        NSDictionary *dic = [TKUserDefault getUserInfo];
        _userModel = [TKUserModel yy_modelWithJSON:dic];
    }
    return _userModel;
}

@end
