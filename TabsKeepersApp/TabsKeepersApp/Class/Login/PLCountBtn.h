//
//  PLCountBtn.h
//  postLoanApp
//
//  Created by tsfa on 2018/12/6.
//  Copyright © 2018 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLCountBtn : UIButton


/**
 开始计时
 */
- (void)startCount;

/**
 按钮点击回调
 */
@property (nonatomic ,copy)void(^loginBtnCLicked)(UIButton *btn);

/**
 倒计时时长(s)
 */
@property (nonatomic ,assign)NSInteger count;


@end

NS_ASSUME_NONNULL_END
