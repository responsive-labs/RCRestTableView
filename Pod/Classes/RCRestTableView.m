//
//  RCRestTableView.m
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import "RCRestTableView.h"
#import "RCRestTableViewViewModel.h"
#import "RCTableViewBindingHelper.h"

@interface RCRestTableView ()
@property (nonatomic,strong) RCTableViewBindingHelper *bindingHelper;
@property (nonatomic,strong) RCRestTableViewViewModel *viewModel;
@end

@implementation RCRestTableView


- (instancetype)initWithJsonString:(NSString*)json{
	self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	if (self) {
		self.viewModel = [[RCRestTableViewViewModel alloc] initWithJsonString:json];
		self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
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
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
	[NSException raise:@"Invalid initializer" format:@"Please use initWithJsonString: instead"];
	return nil;
}

@end