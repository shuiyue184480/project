//
//  Dem_UserData.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_UserData.h"
#import <AVOSCloud/AVOSCloud.h>
static Dem_UserData *handle = nil;
@implementation Dem_UserData

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[Dem_UserData alloc]init];
    });
    return handle;
}

-(instancetype)init{
    _isLog = NO;
    _reLoad = NO;
    if (self.user != nil) {
        AVQuery *query = [AVQuery queryWithClassName:@"Users"];
        [query whereKey:@"user" equalTo:self.user];
        AVObject *Users = [[query findObjects]firstObject];
        self.model.username = [Users objectForKey:@"nid"];
        
        self.model.token = [Users objectForKey:@"token"];
        AVFile *file = [Users objectForKey:@"photo"];
        NSData *data = [file getData];
        self.model.photo = [UIImage imageWithData:data];
    }
    return self;
}

#pragma mark 懒加载
-(Dem_UserModel *)model{
    if (!_model) {
        _model = [[Dem_UserModel alloc]init];
    }
    return _model;
}

-(AVUser *)user{
    if (!_user) {
        _user = [AVUser currentUser];
        
    }
    return _user;
}

#pragma mark 用户登陆
-(void)loginWithUser:(AVUser*)user{
    self.user = user;
    if (user == nil) {
        return;
    }
    AVQuery *query = [AVQuery queryWithClassName:@"Users"];
    [query whereKey:@"user" equalTo:self.user];
    AVObject *Users = [[query findObjects]firstObject];
    self.model.username = [Users objectForKey:@"nid"];
    
    self.model.token = [Users objectForKey:@"token"];
    AVFile *file = [Users objectForKey:@"photo"];
    NSData *data = [file getData];
    self.model.photo = [UIImage imageWithData:data];

}

#pragma mark用户退出
-(void)logoutUser{
    self.model = nil;
    self.isLog = NO;
    self.user = nil;
    [AVUser logOut];
}

@end
