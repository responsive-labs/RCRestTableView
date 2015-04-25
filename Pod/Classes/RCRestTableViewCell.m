//
//  RCRestTableViewCell.m
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import "RCRestTableViewCell.h"
#import "NSValue+RCRestTableVIew.h"

@implementation RCRestTableViewCell

+ (NSString*)cellIdentifier{
	return NSStringFromClass([self class]);
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



@end
