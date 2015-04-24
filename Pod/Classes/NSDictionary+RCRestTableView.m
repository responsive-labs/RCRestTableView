//
//  NSDictionary+RCRestTableView.m
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import "NSDictionary+RCRestTableView.h"

@implementation NSDictionary (RCRestTableView)

+ (instancetype)initWithJsonString:(NSString*)json{
	NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
	return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

@end
