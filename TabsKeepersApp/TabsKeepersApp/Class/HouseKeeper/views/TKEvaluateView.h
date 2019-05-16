//
//  TKEvaluateView.h
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/30.
//  Copyright © 2019 Marco. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKEvaluateView : UIView

- (void)show;

@property (nonatomic ,copy)void (^submitBlock)(void);

@property (nonatomic ,copy)void (^textViewEndEditingBlock)(NSString *text);

@property (nonatomic ,copy)void (^evaluateBlock)(NSInteger level);

@end

NS_ASSUME_NONNULL_END
