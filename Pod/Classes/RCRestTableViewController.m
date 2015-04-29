//
//  RCRestTableViewController.m
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import "RCRestTableViewController.h"
#import "RCRestTableView.h"

@interface RCRestTableViewController ()

@end

@implementation RCRestTableViewController

- (instancetype)initWithJsonString:(NSString*)json{
	self = [super initWithNibName:nil bundle:nil]; // Retrieve an empty table view
	if (self) {
		RCRestTableView *tableView = [[RCRestTableView alloc] initWithJsonString:json];
		self.tableView = tableView;
	}
	return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
	self = [super initWithNibName:nil bundle:nil]; // Retrieve an empty table view
	if (self) {
		RCRestTableView *tableView = [[RCRestTableView alloc] initWithDictionary:dictionary];
		self.tableView = tableView;
	}
	return self;
}

- (instancetype)init{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}
- (instancetype)initWithFrame:(CGRect)frame{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}
- (instancetype) initWithStyle:(UITableViewStyle)style{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}
@end
