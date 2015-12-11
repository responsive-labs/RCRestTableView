// RCUIImageViewCell.m
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
#import "RCUIImageViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSValue+RCRestTableVIew.h"

@interface RCUIImageViewCell() <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *customImageView;
@property (nonatomic,strong) UIPopoverController *popover;
@property (nonatomic,strong) UILabel *myTextLabel;
@property (nonatomic,weak) RCRestTableViewCellViewModel *viewModel;
@end

@implementation RCUIImageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
	if (self) {
		self.detailTextLabel.hidden = YES;
		self.textLabel.hidden = YES;
		self.myTextLabel = [UILabel new];
		[self.myTextLabel setFont:[UIFont systemFontOfSize:14]];
		[self.contentView addSubview:self.myTextLabel];
		self.customImageView = [[UIImageView alloc] init];
		[self.customImageView setUserInteractionEnabled:YES];
		[self.contentView addSubview:self.customImageView];
		[self installConstraints];
		[self bindReactiveSignals];
		
	}
	return self;
}

- (void)installConstraints{
	self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
	self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
	self.myTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	// ContentView constraints
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:10]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:10]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-10]];
	
	// TextLabel contraints
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.myTextLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.myTextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.myTextLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.myTextLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:.35 constant:0]];
	
	// Detail constraints
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.customImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0f]]; // Aspect ratio constraint
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-20]];
}

- (void)bindReactiveSignals{
	@weakify(self)
	[[[[self rac_signalForSelector:@selector(touchesEnded:withEvent:)] reduceEach:^(NSSet *touches, UIEvent *event) {
		return [touches anyObject];
	}]distinctUntilChanged] subscribeNext:^(id x) {
		@strongify(self)
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose Photo", nil];
		[[[actionSheet rac_buttonClickedSignal] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNumber *clickedButton) {
			if ([clickedButton integerValue] == 2) return; // Cancel button
			if ([clickedButton integerValue] == 0 && ![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
				[[[UIAlertView alloc] initWithTitle:nil message:@"Camera Not Available on this device" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
				return;
			}
			UIImagePickerController *imagePickerController = [UIImagePickerController new];
			imagePickerController.sourceType = [clickedButton integerValue] == 0 ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
			imagePickerController.allowsEditing=YES;
			
			@weakify(self,imagePickerController)
			[[imagePickerController rac_imageSelectedSignal] subscribeNext:^(NSDictionary *info) {
				@strongify(self,imagePickerController)
				UIImage *newImage = [info valueForKey:UIImagePickerControllerEditedImage];
				[self.customImageView setImage:newImage];
				// Close the picker
				[imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
				if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
					[self.popover dismissPopoverAnimated:YES];
				
				// Update the View Model
				if (self.viewModel)
					self.viewModel.value = newImage;
			} completed:^{
				@strongify(imagePickerController)
				[imagePickerController.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
			}];
			
			// Dislpay the picker
			if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
				imagePickerController.modalPresentationStyle = UIModalPresentationPopover;
				self.popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
				[self.popover presentPopoverFromRect:self.frame
											  inView:self.tableView
							permittedArrowDirections:UIPopoverArrowDirectionAny
											animated:YES];
			}else{
				UIViewController *controller = self.window.rootViewController;
				imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
				[controller presentViewController:imagePickerController animated:YES completion:nil];
			}
		}];
		[actionSheet showInView:self];
	}];
}

- (void)bindViewModel:(RCRestTableViewCellViewModel*)viewModel{
	[super bindViewModel:viewModel];
	self.viewModel = viewModel;
	self.myTextLabel.text = viewModel.title;
	[self.customImageView setImage:viewModel.value];
	[self.customImageView setBackgroundColor:[UIColor grayColor]];
	
	for (NSString *selectorString in [viewModel.typeProperties allKeys]) {
		SEL selector = NSSelectorFromString(selectorString);
		NSMethodSignature *methodSignature = [self.customImageView methodSignatureForSelector:selector];
		id value = [viewModel.typeProperties objectForKey:selectorString];
		NSInvocation *inv = [NSInvocation invocationWithMethodSignature:methodSignature];
		[inv setSelector:selector];
		[inv setTarget:self.customImageView];
		[value setAsArgumentForInvocation:inv atIndex:2];
		[inv invoke];
	}
}

@end