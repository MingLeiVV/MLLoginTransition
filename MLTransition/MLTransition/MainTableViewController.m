//
//  MainTableViewController.m
//  MLTransition
//
//  Created by 磊 on 16/5/17.
//  Copyright © 2016年 磊. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UIStoryboard *basic = [UIStoryboard storyboardWithName:@"Basic" bundle:nil];
        UIViewController *basicVC = [basic instantiateInitialViewController];
        basicVC.title = @"Basic Sample";
        [self.navigationController pushViewController:basicVC animated:YES];
    }
}
@end
