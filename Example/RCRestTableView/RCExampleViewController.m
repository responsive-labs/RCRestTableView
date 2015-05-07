//
//  RCExampleViewController.m
//  RCRestTableView
//
//  Created by Luca Serpico on 23/04/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import "RCExampleViewController.h"
#import <RCRestTableView/RCRestTableView.h>
#import <RCRestTableView/>

@interface RCExampleViewController ()
@end

@implementation RCExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"RCRestTableView";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0 && indexPath.row == 0) {
		RCRestTableView *tableView = [[RCRestTableView alloc] initWithJsonString:[self exampleJson]];
		UITableViewController *controller = [UITableViewController new];
		controller.tableView = tableView;
		controller.title = @"RCRestTableView - Json";
		[self.navigationController pushViewController:controller animated:YES];
		
	}else if (indexPath.section == 0 && indexPath.row == 1){
		RCRestTableView *tableView = [[RCRestTableView alloc] initWithDictionary:[self exampleDictionary]];
		UITableViewController *controller = [UITableViewController new];
		controller.tableView = tableView;
		controller.title = @"RCRestTableView - Dictionary";
		[self.navigationController pushViewController:controller animated:YES];
		
	}else if (indexPath.section == 0 && indexPath.row == 2){
		RCRestTableView *tableView = [[RCRestTableView alloc] initWithDictionary:[self examplePlist]];
		UITableViewController *controller = [UITableViewController new];
		controller.tableView = tableView;
		controller.title = @"RCRestTableView - Plist";
		[self.navigationController pushViewController:controller animated:YES];
		
	}else if (indexPath.section == 0 && indexPath.row == 3){
		RCRestTableViewController *controller = [[RCRestTableViewController alloc] initWithJsonString:[self exampleJson]];
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
							   @"section_header": @"User profile",
							   @"section_footer": @"Update this section with your personal info",
							   @"rows" : @[
									   @{
										   @"type" : @"UILabel",
										   @"title" : @"Title",
										   @"AccessoryType" : @0,
										   @"value" : @"I'm so lazy to implement this :p",
										   @"UILabel.adjustsFontSizeToFitWidth" : @1
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
