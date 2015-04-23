//
//  RCRestTableView.m
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import "RCRestTableView.h"

@interface RCRestTableView ()

@end

@implementation RCRestTableView

- (instancetype)initWithJsonString:(NSString*)string{
	self = [super initWithStyle:UITableViewStyleGrouped];
	if (self) {
		
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
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}
- (instancetype) initWithStyle:(UITableViewStyle)style{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end
