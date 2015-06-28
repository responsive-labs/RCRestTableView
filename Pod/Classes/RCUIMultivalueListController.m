// RCUIMultivalueListController.m
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

#import "RCUIMultivalueListController.h"

@interface RCUIMultivalueListController()

@property (nonatomic,strong) NSArray *values;

@end

@implementation RCUIMultivalueListController

- (instancetype)initWithValues:(NSArray*)values selectedKey:(NSString*)selectedkey{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self){
		self.values = values;
		self.selectedKey = selectedkey;
		[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	}
	return self;
}

#pragma mark <UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.values count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	NSDictionary *row = [self.values objectAtIndex:indexPath.row];
	NSString *key = [[row allKeys] firstObject];
	NSString *value = [[row allValues] firstObject];
	
	cell.textLabel.text = value;
	
	if ([key isEqualToString:self.selectedKey]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}else{
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	return cell;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSDictionary *row = [self.values objectAtIndex:indexPath.row];
	NSString *key = [[row allKeys] firstObject];

	self.selectedKey = key;
	[self.tableView reloadData];
}

@end
