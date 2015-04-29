//
//  RCExampleViewController.m
//  RCRestTableView
//
//  Created by Luca Serpico on 23/04/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import "RCExampleViewController.h"
#import "RCRestTableViewController.h"
#import "RCRestTableView.h"
#import <objc/message.h>

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
	if (indexPath.section == 0 && indexPath.row == 0) {
		RCRestTableViewController *controller = [[RCRestTableViewController alloc] initWithJsonString:[self exampleJson]];
		[self.navigationController pushViewController:controller animated:YES];
		
	}else if (indexPath.section == 0 && indexPath.row == 1){
		RCRestTableViewController *controller = [[RCRestTableViewController alloc] initWithDictionary:[self exampleDictionary]];
		[self.navigationController pushViewController:controller animated:YES];
		
	}else if (indexPath.section == 0 && indexPath.row == 2){
		RCRestTableViewController *controller = [[RCRestTableViewController alloc] initWithDictionary:[self examplePlist]];
		[self.navigationController pushViewController:controller animated:YES];
		
	}else if (indexPath.section == 0 && indexPath.row == 3){
		RCRestTableView *tableView = [[RCRestTableView alloc] initWithJsonString:[self exampleJson]];
		UITableViewController *controller = [UITableViewController new];
		controller.tableView = tableView;
		[self.navigationController pushViewController:controller animated:YES];
		
	}
}

#pragma mark - Helpers

- (NSString*)exampleJson{
	NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"RCRestTableView" ofType:@"json"];
	return [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
}

- (NSDictionary*)exampleDictionary{
	NSDictionary *dictionary;
	
	dictionary = @{
				   @"sections" : @[
						   @{
							   @"section_header": @"section header name",
							   @"section_footer": @"section footer name",
							   @"rows" : @[
									   @{
										   @"type" : @"UILabel",
										   @"title" : @"Label",
										   @"AccessoryType" : @0,
										   @"value" : @"from dictionary"
									   }
							   ]
						   }
						]
				   };
	
	return dictionary;
}

- (NSDictionary*)examplePlist{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"RCRestTableView" ofType:@"plist"];
	return [[NSDictionary alloc] initWithContentsOfFile:path];
}


@end
