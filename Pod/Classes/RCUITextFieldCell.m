//
//  UITextFieldCell.m
//  Pods
//
//  Created by Luca Serpico on 27/04/2015.
//
//

#import "RCUITextFieldCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSValue+RCRestTableVIew.h"

@interface RCUITextFieldCell()
@property (nonatomic,strong) UITextField *textField;
@end

@implementation RCUITextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
	if (self) {
		self.detailTextLabel.text = @" ";// Set an empty text to keep right margin
		self.detailTextLabel.hidden = YES;
		self.textField = [[UITextField alloc] init];
		self.textField.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:self.textField];
		self.textField.textAlignment = NSTextAlignmentRight;
		[self setNeedsUpdateConstraints];
	}
	return self;
}

- (void)updateConstraints{
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.detailTextLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
	[super updateConstraints];
}

- (void)bindViewModel:(RCRestTableViewCellViewModel*)viewModel{
	[super bindViewModel:viewModel];
	self.textLabel.text = viewModel.title;
	self.textField.text = viewModel.value;
	for (NSString *selectorString in [viewModel.typeProperties allKeys]) {
		SEL selector = NSSelectorFromString(selectorString);
		NSMethodSignature *methodSignature = [self.textField methodSignatureForSelector:selector];
		id value = [viewModel.typeProperties objectForKey:selectorString];
		NSInvocation *inv = [NSInvocation invocationWithMethodSignature:methodSignature];
		[inv setSelector:selector];
		[inv setTarget:self.textField];
		[value setAsArgumentForInvocation:inv atIndex:2];
		[inv invoke];
	}
	
	// Bind textfield with the view model
	RAC(viewModel,value) = [[self.textField rac_textSignal] takeUntil:[self rac_prepareForReuseSignal]];
}

@end
