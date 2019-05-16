//
//  MCNetworking.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/11.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCNetworking : AFHTTPSessionManager

/**
 初始化方法
 */
+ (instancetype)shareInstance;


/**
 GET请求
 
 @param url url
 @param success success
 @param failure failed
 @param showHUD loadingView
 */
+ (void)GETWithUrl:(NSString *)url success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString * _Nonnull errorMsg))failure showHUD:(BOOL)showHUD view:(UIView *)view;


/**
 POST请求
 
 @param url url
 @param parameter para
 @param success success block
 @param failure failed block
 @param showHUD 是否展示loadingView
 */
+ (void)POSTWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString * _Nonnull errorMsg))failure showHUD:(BOOL)showHUD view:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
