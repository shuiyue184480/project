//
//  DAGNewsListView.m
//  Lemon
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "DAGNewsListView.h"

@implementation DAGNewsListView

- (instancetype)initWithFrame:(CGRect)frame
{
       self = [super initWithFrame:frame];
       if (self) {
              [self setupView];
       }
       return self;
}

- (void)setupView {
       self.backgroundColor = [UIColor cyanColor];
       
       self.table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
       [self addSubview:self.table];
       
}

@end
