//
//  SMBaseTableViewController.m
//  HNLVideo
//
//  Created by 谢印超 on 2017/3/6.
//  Copyright © 2017年 谢印超. All rights reserved.
//

#import "SMBaseTableViewController.h"

@interface SMBaseTableViewController () 
@end

@implementation SMBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    
    self.tableView.delegate = self;

    [self.view addSubview:self.tableView];
    
    
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
