//
//  RCRestTableStructure.m
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import "RCRestTableStructure.h"
#import "NSDictionary+RCRestTableView.h"
#import "RCRestTableViewKeys.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RCRestTableStructure()
@property (nonatomic,strong) NSDictionary *structure;
@end

@implementation RCRestTableStructure

- (instancetype)initWithJsonString:(NSString*)json{
	self = [super init];
	if (self) {
		self.structure = [NSDictionary initWithJsonString:json];
		NSLog(@"structure\n %@", self.structure);
		if (!self.structure) [NSException raise:@"Invalid json format" format:@"Please provide a correct json"];
	}
	return self;
}

- (NSArray*)sections{
	return [self.structure objectForKey:kRCRestKeySections];
}
- (NSDictionary*)sectionAtIndex:(NSInteger)section{
	return [[self sections] objectAtIndex:section];
}
- (NSArray*)rowsInSection:(NSInteger)section{
	return [[self sectionAtIndex:section] objectForKey:kRCRestKeyRows];
}
- (NSDictionary*)rowAtIndexPath:(NSIndexPath *)indexPath{
	return [[self rowsInSection:indexPath.section] objectAtIndex:indexPath.row];
}

@end
