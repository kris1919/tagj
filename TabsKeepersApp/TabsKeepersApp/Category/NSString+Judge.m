//
//  NSString+Judge.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "NSString+Judge.h"

@implementation NSString (Judge)

- (BOOL)isPhoneNum{
    NSString *regex = @"^1[0-9]{10}";
    return [self isValidateByRegex:regex];
}

//正则表达式验证
- (BOOL)isValidateByRegex:(NSString *)regex {
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

@end
