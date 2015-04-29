//
//  RCExampleViewController.m
//  RCRestTableView
//
//  Created by Luca Serpico on 23/04/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import "RCExampleViewController.h"
#import "RCRestTableViewController.h"
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
	if (indexPath.section == 0 && indexPath.row == 0){
		NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"RCRestTableView" ofType:@"json"];
		NSString *json = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
		RCRestTableViewController *controller = [[RCRestTableViewController alloc] initWithJsonString:json];
		[self.navigationController pushViewController:controller animated:YES];
		
	}else if (indexPath.section == 0 && indexPath.row == 1){
		
		RCRestTableViewController *controller = [[RCRestTableViewController alloc] initWithDictionary:[self exampleDictionary]];
		[self.navigationController pushViewController:controller animated:YES];
	}
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


@end
