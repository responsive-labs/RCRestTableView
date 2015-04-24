//
//  RCExampleViewController.m
//  RCRestTableView
//
//  Created by Luca Serpico on 23/04/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import "RCExampleViewController.h"
#import "RCRestTableViewController.h"

@interface RCExampleViewController ()
@end

@implementation RCExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0 && indexPath.row == 0){
		NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"RCRestTableView" ofType:@"json"];
		NSString *json = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
		RCRestTableViewController *controller = [[RCRestTableViewController alloc] initWithJsonString:json];
		[self.navigationController pushViewController:controller animated:YES];
	}
}

@end
