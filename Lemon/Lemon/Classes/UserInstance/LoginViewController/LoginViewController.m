//
//  LoginViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "LoginViewController.h"
#import "Dem_LeanCloudData.h"
#import "DHSlideMenuController.h"
#import "Dem_UserData.h"
#import <RongIMKit/RongIMKit.h>
#import <AVOSCloud/AVOSCloud.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTexiField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTexfield;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)loginAction{
    [self.view endEditing:YES];
    [[DHSlideMenuController sharedInstance]hideSlideMenuViewController:NO];
    
    [Dem_LeanCloudData loginWithUserName:self.userNameTexiField.text pwd:self.passWordTexfield.text block:^(AVUser *user) {
        [[Dem_UserData shareInstance]logoutUser];
        if (user !=nil) {
               [[Dem_UserData shareInstance]loginWithUser:user];
               [Dem_UserData shareInstance].isLog = YES;
            [self dismissViewControllerAnimated:YES completion:^{
                [AVUser changeCurrentUser:user save:YES];
            }];
        }
    } error:^(NSError *err) {
        NSLog(@"%@",err);
    }];
}

#pragma mark 点击结束第一响应者
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
