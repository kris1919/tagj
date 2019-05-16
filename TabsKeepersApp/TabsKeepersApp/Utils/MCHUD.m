//
//  MCHUD.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/11.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "MCHUD.h"
#import <MBProgressHUD.h>

@interface MCHUD()

@end

@implementation MCHUD

+ (void)showTips:(NSString *)tips view:(UIView *)view{
    if (tips.length == 0) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = tips;
        [hud hideAnimated:YES afterDelay:1.5f];
    });
}

@end
