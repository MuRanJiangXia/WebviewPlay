//
//  ViewController.m
//  WebviewPlay
//
//  Created by cyan on 2018/2/26.
//  Copyright © 2018年 cyan. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 375, 100)];
    _webView.backgroundColor = [UIColor yellowColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    
    NSString *filpath = [[NSBundle mainBundle]pathForResource:@"index.html" ofType:nil];
    NSString *htmlStr = [[NSString alloc]initWithContentsOfFile:filpath encoding:NSUTF8StringEncoding error:nil];
    
    [_webView loadHTMLString:htmlStr baseURL:nil];
}
#pragma mark - UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法，finish就是调用的方法名
    //点击第一个按钮
    context[@"uitest"] = ^(NSString * str) {
        NSLog(@"%@",str);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式1" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
            [alertView show];
        });
    };
    
    //点击第二个按钮
    context[@"uitest2"] = ^(NSString * str) {
        NSLog(@"%@",str);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"方式2" message:@"这是OC原生的弹出窗" delegate:self cancelButtonTitle:@"收到" otherButtonTitles:nil];
            [alertView show];
        });
    };


}





@end
