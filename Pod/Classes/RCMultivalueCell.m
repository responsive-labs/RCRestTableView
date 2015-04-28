//
//  RCMultivalueCell.m
//  Pods
//
//  Created by Luca Serpico on 28/04/2015.
//
//

#import "RCMultivalueCell.h"
#import "NSValue+RCRestTableVIew.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RCUIMultivalueListController.h"

@interface RCMultivalueCell()
@property (nonatomic,strong) NSArray *values;
@property (nonatomic,weak) RCRestTableViewCellViewModel *viewModel;
@end

@implementation RCMultivalueCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
	if (self) {
		self.values = @[];
		[self bindReactiveSignals];
	}
	return self;
}

- (void)bindReactiveSignals{
	[[[[self rac_signalForSelector:@selector(touchesBegan:withEvent:)] reduceEach:^(NSSet *touches, UIEvent *event) {
		return [touches anyObject];
	}]distinctUntilChanged] subscribeNext:^(id x) {
		UINavigationController *controller = (UINavigationController*)self.window.rootViewController;
		RCUIMultivalueListController *listController = [[RCUIMultivalueListController alloc] initWithValues:self.values selectedValue:self.detailTextLabel.text];
		[controller pushViewController:listController animated:YES];

		@weakify(self)
		[[RACObserve(listController, selectedValue) takeUntil:[listController rac_willDeallocSignal]] subscribeNext:^(NSString *newValue) {
			@strongify(self)
			[self.viewModel setValue:newValue];
			[self.detailTextLabel setText:newValue];
		}];
	}];
}

- (void)bindViewModel:(RCRestTableViewCellViewModel*)viewModel{
	[super bindViewModel:viewModel];
	self.viewModel = viewModel;
	[self setSelectionStyle:UITableViewCellSelectionStyleNone];
	[self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
	
	self.textLabel.text = viewModel.title;
	self.detailTextLabel.text = viewModel.value;
	self.values = viewModel.values;
	
	for (NSString *selectorString in [viewModel.typeProperties allKeys]) {
		SEL selector = NSSelectorFromString(selectorString);
		NSMethodSignature *methodSignature = [self.detailTextLabel methodSignatureForSelector:selector];
		id value = [viewModel.typeProperties objectForKey:selectorString];
		NSInvocation *inv = [NSInvocation invocationWithMethodSignature:methodSignature];
		[inv setSelector:selector];
		[inv setTarget:self.detailTextLabel];
		[value setAsArgumentForInvocation:inv atIndex:2];
		[inv invoke];
	}
}


@end
