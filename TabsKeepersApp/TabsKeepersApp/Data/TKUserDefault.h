//
//  TKUserDefault.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKUserDefault : NSObject

/**
 第一次登陆
 */
+ (void)setIsFirstLogin:(BOOL)isFirstLogin;
+ (BOOL)getIsFirstLogin;


/**
 登陆状态
 */
+ (void)setIsLogin:(BOOL)isLogin;
+ (BOOL)getIsLogin;

/**
 用户信息
 */
+ (void)setUserInfo:(NSDictionary *)userInfo;
+ (NSDictionary *)getUserInfo;

@end

NS_ASSUME_NONNULL_END
