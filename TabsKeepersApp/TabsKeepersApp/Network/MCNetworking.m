//
//  MCNetworking.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/11.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "MCNetworking.h"
#import <MBProgressHUD.h>

@implementation MCNetworking

+ (instancetype)shareInstance{
    static MCNetworking *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
-(instancetype)initWithBaseURL:(NSURL *)url{
    if (self = [super initWithBaseURL:url]) {
        /**设置请求超时时间*/
        self.requestSerializer.timeoutInterval = 8.0f;
        /**设置相应的缓存策略*/
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        /**分别设置请求以及相应的序列化器*/
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        self.responseSerializer = response;
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        [self.requestSerializer setValue:@"application/x-www-form-urlencoded"  forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    
    return self;
}
+ (void)GETWithUrl:(NSString *)url success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString * _Nonnull errorMsg))failure showHUD:(BOOL)showHUD view:(UIView *)view{
    MBProgressHUD *hud;
    if (showHUD) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    [[MCNetworking shareInstance] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [responseObject objectForKey:kTKResponseResultCode];
        if (code.integerValue == 1) {
            if (success) {
                success(responseObject);
            }
        }else{
            if (failure) {
                failure([responseObject objectForKey:kTKResponseResultMsg]);
            }
        }
        if (showHUD) {
            [hud hideAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error.localizedDescription);
        }
        if (showHUD) {
            [hud hideAnimated:YES];
        }
    }];
}
+ (void)POSTWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString * _Nonnull errorMsg))failure showHUD:(BOOL)showHUD view:(UIView *)view{
    MBProgressHUD *hud;
    if (showHUD) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    [[MCNetworking shareInstance] POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [responseObject objectForKey:kTKResponseResultCode];
        if (code.integerValue == 1) {
            if (success) {
                success(responseObject);
            }
        }else{
            if (failure) {
                failure([responseObject objectForKey:kTKResponseResultMsg]);
            }
        }
        if (showHUD) {
            [hud hideAnimated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error.localizedDescription);
        }
        if (showHUD) {
            [hud hideAnimated:YES];
        }
    }];
}
@end
