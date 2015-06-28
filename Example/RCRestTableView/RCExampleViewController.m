// RCExampleViewController.m
// Copyright (c) 2015 Research Central (http://www.researchcentral.co/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RCExampleViewController.h"
#import <RCRestTableView/RCRestTableView.h>
#import "RCRestTableViewController.h"

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
