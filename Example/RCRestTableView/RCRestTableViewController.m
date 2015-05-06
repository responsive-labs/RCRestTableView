//
//  RCRestTableViewController.m
//  RCRestTableView
//
//  Created by Luca Serpico on 06/05/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import "RCRestTableViewController.h"
#import <RCRestTableView/RCRestTableView.h>

@interface RCRestTableViewController()
@property (nonatomic,strong) RCRestTableView *tableView;
@end

@implementation RCRestTableViewController
@dynamic tableView;

- (instancetype)initWithJsonString:(NSString*)json{
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self) {
		self.tableView = [[RCRestTableView alloc] initWithJsonString:json];
		UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
		self.navigationItem.rightBarButtonItem = save;
	}
	return self;
}

- (IBAction)save:(id)sender{
	NSLog(@"%@",[self.tableView values]);
	
}

@end
