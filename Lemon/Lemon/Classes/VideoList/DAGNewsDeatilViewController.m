//
//  DAGNewsDeatilViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGNewsDeatilViewController.h"

@interface DAGNewsDeatilViewController ()<UIWebViewDelegate>

@end
static BOOL isLoading = NO;
@implementation DAGNewsDeatilViewController

- (void)loadView {
       [super loadView];
       self.dnd = [[DAGNewsDetail alloc] initWithFrame:[UIScreen mainScreen].bounds];
       self.view = self.dnd;
}

- (void)viewDidLoad {
    [super viewDidLoad];
       
       NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.detailUrl]];
       NSLog(@"%@", self.detailUrl);
       self.dnd.webView.delegate = self;
       [self.dnd.webView loadRequest:request];
       
       
    // Do any additional setup after loading the view.
}




//实现协议
//开始加载的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView {
       NSLog(@"开始加载");
       
       if (isLoading == NO) {
              
       
       
       //创建UIActivityIndicatorView背底半透明View
       UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
       [view setTag:108];
       [view setBackgroundColor:[UIColor blackColor]];
       [view setAlpha:0.5];
       [self.view addSubview:view];
       //
       UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
       //    [act setCenter:CGPointMake(10, 200)];
       [act setCenter:view.center];//设置旋转菊花的中心位置
       [act setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置菊花的样式
       [view addSubview: act];
       
       [act startAnimating];
              
              NSLog(@"123");
              isLoading = YES;
       }
       
}

//加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
       
       //    取消view
       UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
       [act stopAnimating];
       UIView *view = (UIView*)[self.view viewWithTag:108];
       [view removeFromSuperview];
       
       NSLog(@"加载失败");
}

//加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView {
       //    取消view
       UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
       [act stopAnimating];
       UIView *view = (UIView*)[self.view viewWithTag:108];
       [view removeFromSuperview];
       
       NSLog(@"加载完成");
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
