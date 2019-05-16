//
//  ServiceProtocalViewController.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/5/11.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "ServiceProtocalViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>

@interface ServiceProtocalViewController ()
@property (nonatomic ,strong)WKWebView *webView;

@end

@implementation ServiceProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setUrlStr:(NSString *)urlStr{
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(kNavigationBar_Height, 0, 0, 0));
        }];
    }
    return _webView;
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
