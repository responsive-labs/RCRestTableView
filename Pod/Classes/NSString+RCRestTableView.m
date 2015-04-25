//
//  NSString+RCRestTableView.m
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import "NSString+RCRestTableView.h"

@implementation NSString (RCRestTableView)

- (NSString*)uppercaseFirstLetter{
	NSString *firstChar = [self substringToIndex:1];
	return [firstChar stringByAppendingString:[self substringFromIndex:1]];
}

@end
