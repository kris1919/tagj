//
//  ImageDisplayViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/16.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ImageDisplayViewController.h"

@interface ImageDisplayViewController ()

@end

@implementation ImageDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.displayActionButton = NO;
    self.displayDoneButton = NO;
    self.dismissOnTouch = YES;
    self.disableVerticalSwipe = NO;
    self.forceHideStatusBar = NO;
    self.displayCounterLabel = YES;
    self.autoHideInterface = NO;
    self.usePopAnimation = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
