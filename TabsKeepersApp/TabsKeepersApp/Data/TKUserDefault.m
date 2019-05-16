//
//  TKUserDefault.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKUserDefault.h"

@implementation TKUserDefault

/**
 第一次登陆
 */
+ (void)setIsFirstLogin:(BOOL)isFirstLogin{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(isFirstLogin) forKey:@"userDefault_tk_isFirstLogin"];
    [userDefaults synchronize];
}
+ (BOOL)getIsFirstLogin{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults objectForKey:@"userDefault_tk_isFirstLogin"] boolValue];
}


/**
 登陆状态
 */
+ (void)setIsLogin:(BOOL)isLogin{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(isLogin) forKey:@"userDefault_tk_isLogin"];
    [userDefaults synchronize];
}
+ (BOOL)getIsLogin{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults objectForKey:@"userDefault_tk_isLogin"] boolValue];
}

+ (void)setUserInfo:(NSDictionary *)userInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:userInfo forKey:@"userDefault_tk_userInfo"];
    [userDefaults synchronize];
}
+ (NSDictionary *)getUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"userDefault_tk_userInfo"];
}

@end
