//
//  RCUIImageViewCell.m
//  Pods
//
//  Created by Luca Serpico on 27/04/2015.
//
//

#import "RCUIImageViewCell.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSValue+RCRestTableVIew.h"
#import "UIImage+RCRestTableView.h"

@interface RCUIImageViewCell() <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *customImageView;
@property (nonatomic,strong) UIPopoverController *popover;
@property (nonatomic,weak) RCRestTableViewCellViewModel *viewModel;
@end

@implementation RCUIImageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
	if (self) {
		self.detailTextLabel.hidden = YES;
		self.customImageView = [[UIImageView alloc] init];
		[self.customImageView setUserInteractionEnabled:YES];
		[self.contentView addSubview:self.customImageView];
		[self setNeedsUpdateConstraints];
		[self bindReactiveSignals];
		
	}
	return self;
}

- (void)bindReactiveSignals{
	@weakify(self)
	[[[[self rac_signalForSelector:@selector(touchesBegan:withEvent:)] reduceEach:^(NSSet *touches, UIEvent *event) {
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

- (void)updateConstraints{
	self.customImageView.translatesAutoresizingMaskIntoConstraints = NO;
	self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
	
	[self.textLabel setContentCompressionResistancePriority:501 forAxis:UILayoutConstraintAxisHorizontal];
	[self.customImageView setContentCompressionResistancePriority:500 forAxis:UILayoutConstraintAxisHorizontal];
	[self.textLabel setContentHuggingPriority:501 forAxis:UILayoutConstraintAxisHorizontal];
	[self.customImageView setContentHuggingPriority:500 forAxis:UILayoutConstraintAxisHorizontal];
	
	// TextLabel contraints
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:16]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:9]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.textLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
	
	// ImageView constraints
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeTrailing multiplier:1 constant:8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-8]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-16]];
	[super updateConstraints];
}

- (void)bindViewModel:(RCRestTableViewCellViewModel*)viewModel{
	[super bindViewModel:viewModel];
	self.viewModel = viewModel;
	self.textLabel.text = viewModel.title;
	[self.customImageView setImage:[UIImage findImageWithValue:viewModel.value]];
	
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