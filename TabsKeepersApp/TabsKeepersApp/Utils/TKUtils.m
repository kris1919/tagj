//
//  TKUtils.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKUtils.h"

@implementation TKUtils

+ (__kindof UIViewController *)viewControllerWithStory:(NSString *)story storyId:(NSString *)storyId{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:story bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:storyId];
}

+ (UIView *)nibWithNibName:(NSString *)nibName{
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}

@end
