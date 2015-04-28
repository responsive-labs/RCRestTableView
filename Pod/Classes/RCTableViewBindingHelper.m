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
#import "RCRestTableViewCellAvailable.h"

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
		
		[self.tableView registerClass:[RCRestTableViewCell class] forCellReuseIdentifier:[RCRestTableViewCell cellIdentifier]];
		[self.tableView registerClass:[RCUILabelCell class] forCellReuseIdentifier:[RCUILabelCell cellIdentifier]];
		[self.tableView registerClass:[RCUITextFieldCell class] forCellReuseIdentifier:[RCUITextFieldCell cellIdentifier]];
		[self.tableView registerClass:[RCUIImageViewCell class] forCellReuseIdentifier:[RCUIImageViewCell cellIdentifier]];
		[self.tableView registerClass:[RCUISwitchCell class] forCellReuseIdentifier:[RCUISwitchCell cellIdentifier]];
		[self.tableView registerClass:[RCMultivalueCell class] forCellReuseIdentifier:[RCMultivalueCell cellIdentifier]];
		
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	RCRestTableViewCellViewModel *cellViewModel = [self.viewModel viewModelForRowAtIndexPath:indexPath];
	NSString *cellIdentifier = cellViewModel.cellIdentifier;
	
	RCRestTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
	
	[cell bindViewModel:cellViewModel];
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return [self.viewModel titleForHeaderInSection:section];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
	return [self.viewModel titleForFooterInSection:section];
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
