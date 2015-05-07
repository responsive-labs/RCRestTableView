//
//  UIView+RCRestTableView.m
//  Pods
//
//  Created by Luca Serpico on 07/05/2015.
//
//

#import "UIView+RCRestTableView.h"

@implementation UIView (RCRestTableView)

- (UIViewController *)parentViewController {
	UIResponder *responder = self;
	while ([responder isKindOfClass:[UIView class]])
		responder = [responder nextResponder];
	return (UIViewController*)responder;
}

@end
