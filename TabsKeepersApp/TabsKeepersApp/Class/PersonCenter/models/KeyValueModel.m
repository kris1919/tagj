//
//  KeyValueModel.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/13.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "KeyValueModel.h"

@implementation KeyValueModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"code" : @[@"gxId",@"lxId",@"code"],
             @"name" : @[@"gxName",@"lxName",@"name"]};
}

@end
