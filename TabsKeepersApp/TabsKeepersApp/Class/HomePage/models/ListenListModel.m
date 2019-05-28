//
//  ListenListModel.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/27.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ListenListModel.h"

@implementation ListenDeviceModel

@end

@implementation ListenListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"shebei" : [ListenDeviceModel class]
             };
}

@end
