// RCRestTableViewCell.m
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

#import "RCRestTableViewCell.h"
#import "NSValue+RCRestTableVIew.h"

@interface RCRestTableViewCell()
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation RCRestTableViewCell

+ (NSString*)cellIdentifier{
	return NSStringFromClass([self class]);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.textLabel.font = [UIFont systemFontOfSize:14.0];
	}
	return self;
}

- (void)bindViewModel:(RCRestTableViewCellViewModel*)viewModel{
	for (NSString *selectorString in [viewModel.cellProperties allKeys]) {
		SEL selector = NSSelectorFromString(selectorString);
		NSMethodSignature *methodSignature = [self methodSignatureForSelector:selector];
		id value = [viewModel.cellProperties objectForKey:selectorString];
		NSInvocation *inv = [NSInvocation invocationWithMethodSignature:methodSignature];
		[inv setSelector:selector];
		[inv setTarget:self];
		[value setAsArgumentForInvocation:inv atIndex:2];
		[inv invoke];
	}
	
}

- (UITableView*)tableView{
	if (!_tableView){
		id view = [self superview];
		
		while (view && [view isKindOfClass:[UITableView class]] == NO) {
			view = [view superview];
		}
		
		_tableView = (UITableView *)view;
	}
	return _tableView;
}

@end
