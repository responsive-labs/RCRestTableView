//
//  RCUISwitchCell.m
//  Pods
//
//  Created by Luca Serpico on 28/04/2015.
//
//

#import "RCUISwitchCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSValue+RCRestTableVIew.h"

@interface RCUISwitchCell()
@property (nonatomic,strong) UISwitch *customSwitch;
@end

@implementation RCUISwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
	if (self) {
		self.detailTextLabel.hidden = YES;
		self.customSwitch = [[UISwitch alloc] init];
		[self.contentView addSubview:self.customSwitch];
		[self setNeedsUpdateConstraints];
	}
	return self;
}

- (void)updateConstraints{
	self.customSwitch.translatesAutoresizingMaskIntoConstraints = NO;
	
	// ImageView constraints
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customSwitch attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customSwitch attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customSwitch attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-16]];
	[super updateConstraints];
}
- (void)bindViewModel:(RCRestTableViewCellViewModel*)viewModel{
	[super bindViewModel:viewModel];
	self.textLabel.text = viewModel.title;
	[self.customSwitch setOn:[viewModel.value boolValue]];

	for (NSString *selectorString in [viewModel.typeProperties allKeys]) {
		SEL selector = NSSelectorFromString(selectorString);
		NSMethodSignature *methodSignature = [self.customSwitch methodSignatureForSelector:selector];
		id value = [viewModel.typeProperties objectForKey:selectorString];
		NSInvocation *inv = [NSInvocation invocationWithMethodSignature:methodSignature];
		[inv setSelector:selector];
		[inv setTarget:self.customSwitch];
		[value setAsArgumentForInvocation:inv atIndex:2];
		[inv invoke];
	}
}

@end