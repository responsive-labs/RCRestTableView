// RCRestTableView.m
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

#import "RCRestTableView.h"
#import "NSDictionary+RCRestTableView.h"
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
		NSDictionary *dictionary = [NSDictionary initWithJsonString:json];
		if (!dictionary) [NSException raise:@"Invalid json format" format:@"Please provide a correct json"];

		self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
		self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	}
	return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
	self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	if (self) {
		self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
		self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	}
	return self;
}

#pragma mark - Actions
- (void)setJsonStructure:(NSString*)json{
	NSDictionary *dictionary = [NSDictionary initWithJsonString:json];
	if (!dictionary) [NSException raise:@"Invalid json format" format:@"Please provide a correct json"];
	self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
	self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	[self reloadData];
}

- (void)setDictionaryStructure:(NSDictionary*)dictionary{
	self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
	self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	[self reloadData];
}

- (NSDictionary*)values{
	return [self.viewModel values];
}

- (void)setValues:(NSDictionary*)values{
	[self.viewModel setValues:values];
	[self reloadData];
}

- (void)setPropertyValue:(id)value withKey:(NSString *)key forCellIdentifier:(NSString *)cellIdentifier withSectionIdentifier:(NSString *)sectionIdentifier{
	[self.viewModel setPropertyValue:value withKey:key forCellIdentifier:cellIdentifier withSectionIdentifier:sectionIdentifier];
	[self reloadData];
}
- (void)setMultivaluesItems:(NSArray*)items forCellIdentifier:(NSString*)identifier{
	[self.viewModel setMultivaluesItems:items forCellIdentifier:identifier];
	[self reloadData];
}
@end
