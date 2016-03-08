//
//  DAGMyViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/5.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGMyViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "DAGDownLoadViewController.h"

@interface DAGMyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *data;

@end

@implementation DAGMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
       self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
       [self.view addSubview:self.tableView];
       
       self.tableView.dataSource = self;
       self.tableView.delegate = self;
       [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCell"];
       
       
       
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
       if (indexPath.row == 0) {
              cell.textLabel.text = @"我的下载";
              
       }else {
       cell.textLabel.text = @"清除缓存";
       }
       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
       if (indexPath.row == 0) {
              DAGDownLoadViewController *ddlc = [[DAGDownLoadViewController alloc] init];
              [self.navigationController pushViewController:ddlc animated:YES];
       }
       AVUser *user = [AVUser currentUser];
       
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
