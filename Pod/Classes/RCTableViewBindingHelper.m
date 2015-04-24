//
//  RCTableViewBindingHelper.m
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import "RCTableViewBindingHelper.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RCReactiveView.h"
#import "RCRestTableViewViewModel.h"

@interface RCTableViewBindingHelper() <UITableViewDataSource, UITableViewDelegate>

/** Supplied table view. */
@property (nonatomic,weak) UITableView *tableView;

/** Supplied View Model */
@property (nonatomic,weak) RCRestTableViewViewModel *viewModel;

@end

@implementation RCTableViewBindingHelper

- (instancetype)initWithTableView:(UITableView *)tableView
					 viewModel:(RCRestTableViewViewModel*)viewModel{
	if (self = [super init]) {
		self.tableView = tableView;
		self.viewModel = viewModel;
		
		self.tableView.rowHeight = 44.0f; // Default UITableViewCellSize
		
		_tableView.dataSource = self;
		_tableView.delegate = self;
	}
	
	return self;
}

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
								viewModel:(RCRestTableViewViewModel*)viewModel{
	
	return [[RCTableViewBindingHelper alloc] initWithTableView:tableView
													 viewModel:viewModel];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cel = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
	cel.textLabel.text = @"test";
	return cel;
//	id<RCReactiveView> cell = [tableView dequeueReusableCellWithIdentifier:@""];
//	if ([cell respondsToSelector:@selector(bindViewModel:)]) {
//		[cell bindViewModel:self.data[indexPath.row]];
//	} else {
//		[NSException raise:@"The cells supplied to the RCTableViewBindingHelper must implement the protocol RCReactiveView" format:@"missing method `bindViewModel:`"];
//	}
//	return (UITableViewCell *)cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [self.viewModel titleForHeaderInSection:section];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	return [self.viewModel titleForFooterInSection:section];
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	if (self.selection) {
//		[self.selection execute:_data[indexPath.row]];
//	}
}

@end
