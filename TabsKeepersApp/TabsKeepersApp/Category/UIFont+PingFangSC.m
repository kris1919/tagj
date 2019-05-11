//
//  UIFont+PingFangSC.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "UIFont+PingFangSC.h"

@implementation UIFont (PingFangSC)


+ (UIFont *)pingFangFontOfSize:(CGFloat)fontSize{
    if (@available(iOS 9.0,*)) {
        return [UIFont fontWithName:@".PingFangSC-Regular" size:fontSize];
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)boldPingFangFontOfSize:(CGFloat)fontSize{
    if (@available(iOS 9.0,*)) {
        return [UIFont fontWithName:@".PingFangSC-Medium" size:fontSize];
    }
    return [UIFont boldSystemFontOfSize:fontSize];
}

@end
