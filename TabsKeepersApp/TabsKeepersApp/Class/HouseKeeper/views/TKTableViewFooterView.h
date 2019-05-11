//
//  TKTableViewFooterView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/5.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKTableViewFooterView : UIView

@property (nonatomic ,copy)NSString *imageName;

@property (nonatomic ,copy)NSString *btnTitle;

@property (nonatomic ,copy)void (^buttonActionBlock)(UIButton *btn);

@end

NS_ASSUME_NONNULL_END
