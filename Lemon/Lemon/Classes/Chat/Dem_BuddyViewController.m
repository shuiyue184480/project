//
//  Dem_BuddyViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "Dem_BuddyViewController.h"
#import "Dem_UserData.h"
#import "Dem_GroupViewController.h"
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>
#import <AVOSCloudIM/AVOSCloudIM.h>

@interface Dem_BuddyViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *group;
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)NSMutableArray *budArr;
@property(nonatomic,assign)int num;
@end

@implementation Dem_BuddyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.budArr = [NSMutableArray array];
    [Dem_LeanCloudData intermationWithUser:self.user block:^(AVObject *users) {
        self.name.text = [users objectForKey:@"nid"];
        AVFile *file = [users objectForKey:@"photo"];
        NSData *data = [file getData];
        self.photo.image = [UIImage imageWithData:data];
    }];
    
    _num = 0;
    [Dem_LeanCloudData groupWithUser:[Dem_UserData shareInstance].user block:^(AVObject *group) {
        self.array = [NSMutableArray array];
        self.array = [group objectForKey:@"groupName"];
        
    }];
    [self.group addTarget:self action:@selector(groupAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr = [Dem_LeanCloudData buddyWithUser:[Dem_UserData shareInstance].user];
    for (AVObject *friend in arr) {
        AVUser *user = [friend objectForKey:@"friend"];
        [self.budArr addObject:user];
    }
    
    if ([self.user isEqual:[Dem_UserData shareInstance].user] ) {
        self.group.hidden = YES;
        [self.button setTitle:@"编辑资料" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        BOOL isAdd = [self.budArr containsObject:self.user];
        if (isAdd == YES) {
            self.group.hidden = YES;
            [self.button setTitle:@"删除好友" forState:UIControlStateNormal];
            [self.button addTarget:self action:@selector(delAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else{
            self.group.hidden = NO;
            [self.button addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    // Do any additional setup after loading the view.
}
#pragma mark 编辑资料
-(void)editAction{
    
}
#pragma mark 删除好友
-(void)delAction{
    [Dem_LeanCloudData delectWithUser:[Dem_UserData shareInstance].user buddy:self.user];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark 选择组
-(void)groupAction{
    Dem_GroupViewController *gvc = [[Dem_GroupViewController alloc]init];
    gvc.group = self.array;
    [self.navigationController pushViewController:gvc animated:YES];
    gvc.block =^ (int value){
        _num = value;
    };
}
#pragma mark添加好友
-(void)addAction{
    [Dem_LeanCloudData addBuddyWithUser:[Dem_UserData shareInstance].user buddy:self.user group:self.array[_num]];
    [self.navigationController popToRootViewControllerAnimated:YES];
       
       
       
       RCMessage *message = [[RCMessage alloc] initWithType:ConversationType_SYSTEM targetId:self.user.username direction:MessageDirection_SEND messageId:1 content:[RCContactNotificationMessage notificationWithOperation:ContactNotificationMessage_ContactOperationRequest sourceUserId:[Dem_UserData shareInstance].user.username targetUserId:self.user.username message:@"可以添加你为好友吗？" extra:@""]];
       
       message.objectName = RCContactNotificationMessageIdentifier;
       
       RCMessageContent *content = nil;
       
      [[RCIM sharedRCIM] sendMessage:ConversationType_SYSTEM targetId:self.user.username content:content pushContent:@"添加好友" pushData:@"qwer" success:^(long messageId) {
             
      } error:^(RCErrorCode nErrorCode, long messageId) {
             
      }];
       
       
}

-(void)viewWillAppear:(BOOL)animated{
    [self.group setTitle:self.array[_num] forState:UIControlStateNormal];
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
