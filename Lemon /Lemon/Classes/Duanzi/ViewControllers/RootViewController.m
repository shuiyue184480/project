//
//  RootViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "RootViewController.h"
#import "TextTableViewCell.h"
#import "PicTableViewCell.h"
#import "DataHandel.h"
#import "MJRefresh.h"
#import "DataHandel.h"
#import "SG_Model.h"
#import "UIImageView+WebCache.h"
#import "CommentViewController.h"
#import "LoginViewController.h"
@interface RootViewController ()<UITableViewDataSource ,UITableViewDelegate>

@end

@implementation RootViewController

- (void)loadView{
    [super loadView];
    self.rv = [[RootView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.rv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"笑料百态";
    self.rv.table.delegate = self;
    self.rv.table.dataSource = self;
    self.rv.table.separatorColor = [UIColor grayColor];
    self.rv.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.rv.table addHeaderWithTarget:self action:@selector(headerRereshing)];
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    self.navigationItem.rightBarButtonItem = rigthItem;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(commentAction:) name:@"comment" object:nil];
    
    
    [self.rv.segement addTarget:self action:@selector(segementAction:) forControlEvents:UIControlEventValueChanged];
    
    //设置自动调整scrollView边距为NO 使其不调整
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    [self.rv.table registerNib:[UINib nibWithNibName:@"TextTableViewCell" bundle:nil] forCellReuseIdentifier:@"TextCell"];
    [self.rv.table registerNib:[UINib nibWithNibName:@"PicTableViewCell" bundle:nil] forCellReuseIdentifier:@"PicCell"];
    
    [[DataHandel shareInstance] requestDuanziDataWithUrl:PicURL finshed:^{
        
       [self.rv.table reloadData];
    }];
}



- (void) addAction:(UIBarButtonItem *)sender{
    
    NSLog(@"发帖");
    
    
    
}

- (void)commentAction:(NSNotification *)sender{
    
    
    LoginViewController *login =[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"lvc"];
    
    [self presentViewController:login animated:YES completion:nil];
    

    
//    CommentViewController *comment = [[CommentViewController alloc] init];
//    self.tabBarController.tabBar.hidden = YES;
//    [self.navigationController pushViewController:comment animated:YES];
//    
    

}

- (void)headerRereshing{
  
//    [[DataHandel shareInstance] requestDuanziDataWithUrl:DuziUrl finshed:^{
//        
//        [self.rv.table reloadData];
//        
//    }];
    
   [self performSelector:@selector(refresh123) withObject:nil afterDelay:1.5];
    
}

- (void)refresh123{
    
    [self.rv.table headerEndRefreshing];
     
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [DataHandel shareInstance].countOfDataArray;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    SG_Model *model = [[DataHandel shareInstance]modelAtIndexPath:indexPath];
   if (model.image0 == nil) {
      
       TextTableViewCell *textCell  = [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
       
        [textCell.userPhotoView sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
        textCell.userNameLabel.text = model.name;
        textCell.ContentsLabel.text = nil;
        textCell.ContentsLabel.text = model.text ;
        textCell.CheckDetailLabel.text = [NSString stringWithFormat:@"赞:%@ 踩:%@ 分享:%@", model.love,model.hate,model.comment];
 
        cell = textCell;

 
    }else{
        
        PicTableViewCell *picCell = [tableView dequeueReusableCellWithIdentifier:@"PicCell" forIndexPath:indexPath];
        [picCell.userPhotoView sd_setImageWithURL:[NSURL URLWithString:model.profile_image]];
        picCell.userNameLabel.text =model.name;
        [picCell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.image0] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        picCell.contentDetailLabel.text = model.text;
        picCell.checkDetailLabel.text = [NSString stringWithFormat:@"赞:%@    踩:%@    分享:%@", model.love,model.hate,model.comment];
        cell = picCell;
    }

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

      SG_Model *model = [[DataHandel shareInstance]modelAtIndexPath:indexPath];
    
    if (model.image0 == nil) {
        
        return [[DataHandel shareInstance] heightForCell:model.text] +5+35+5+5+20+5+20+5+35 +50;
        
        
    }else if(self.rv.table.frame.size.width*[model.height intValue]/[model.width intValue]  > self.view.frame.size.height *0.6) {
        
      
        return [[DataHandel shareInstance]heightForCell:model.text]+5+35+5+5+20+5+20+5+35 +50+self.rv.table.frame.size.width*[model.height intValue] *0.6/[model.width intValue] ;
        
    }
        else{
    
         return [[DataHandel shareInstance]heightForCell:model.text]+5+35+5+5+20+5+20+5+35 +50+self.rv.table.frame.size.width*[model.height intValue]/[model.width intValue] ;
    }

    
}



- (void)segementAction:(UISegmentedControl *)sender{
    
    
    switch (sender.selectedSegmentIndex) {
       
        case 0: {[[DataHandel shareInstance] requestDuanziDataWithUrl:DuziUrl finshed:^{
           
            [self.rv.table reloadData];
            
        }]; }break;
        case 1: {
        [[DataHandel shareInstance] requestDuanziDataWithUrl:PicURL finshed:^{
            
            [self.rv.table reloadData];
        }];
        
        }break;
        case 2: {}break;
        case 3: {}break;
            
            
            
        default:NSLog(@"asdf");
            break;
    }
    
    
    NSLog(@"点解了第%ld个",sender.selectedSegmentIndex);
    
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    
    
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
