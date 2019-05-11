//
//  TKKeyValueModel.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKKeyValueModel.h"

@implementation TKKeyValueModel

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value{
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
    }
    return self;
}

@end
