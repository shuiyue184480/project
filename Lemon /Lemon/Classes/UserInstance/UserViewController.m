//
//  UserViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "UserViewController.h"
#import "Dem_UserData.h"


@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *loadButton;

@property(nonatomic,strong)NSMutableArray *array;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    NSArray *arr1 = @[@"修改信息"];
    NSArray *arr2 = @[@"退出"];
    [self.array addObject:arr1];
    [self.array addObject:arr2];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.loadButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)loginAction{
    [Dem_UserData shareInstance].reLoad = YES;
}


-(void)viewWillAppear:(BOOL)animated{
    self.photo.image = [Dem_UserData shareInstance].model.photo;
    self.name.text = [Dem_UserData shareInstance].model.username;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user_cell" forIndexPath:indexPath];
    cell.textLabel.text = self.array[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSLog(@"xiugai");
        }
    }
    else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            NSLog(@"zhuxiao");
        }
    }
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
