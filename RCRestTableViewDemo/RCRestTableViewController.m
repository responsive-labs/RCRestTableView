// RCRestTableViewController.m
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
		self.title = @"RCRestTableView - Custom";
	}
	return self;
}

- (IBAction)save:(id)sender{
	NSDictionary *values = [self.tableView values];
	NSString *message = [NSString stringWithFormat:@"Values:\n%@",values];
	UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"RCRestTableView" message:message preferredStyle:UIAlertControllerStyleAlert];
	[controller addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
	[self presentViewController:controller animated:YES completion:nil];
}

@end
