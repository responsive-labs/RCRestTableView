// RCTableViewBindingHelper.m
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
		[self.tableView registerClass:[RCSZTextViewCell class] forCellReuseIdentifier:[RCSZTextViewCell cellIdentifier]];
		
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
	
	if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1){
		[cell layoutSubviews];
	}
	
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
