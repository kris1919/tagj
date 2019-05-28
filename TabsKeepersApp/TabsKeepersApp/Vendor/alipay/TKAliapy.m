//
//  TKAliapy.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKAliapy.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation TKAliapy

+ (void)alipayWithSign:(NSString *)signedString callBack:(void(^)(NSDictionary *resultDic))callBack{
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        NSString *appScheme = @"tabsAlipay";
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:signedString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            if (callBack) {
                callBack(resultDic);
            }
        }];
    }
}

@end
