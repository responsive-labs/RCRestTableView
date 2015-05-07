//
//  RCRestTableViewCell.m
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

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
