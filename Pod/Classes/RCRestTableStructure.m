//
//  RCRestTableStructure.m
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import "RCRestTableStructure.h"
#import "RCRestTableViewKeys.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RCRestTableStructure()
@property (nonatomic,strong) NSDictionary *structure;
@end

@implementation RCRestTableStructure

- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
	self = [super init];
	if (self) {
		self.structure = dictionary;
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

- (NSInteger)indexOfSectionWithIdentifier:(NSString*)sectionIdentifier{
	for (int i = 0; i < [[self sections] count]; i++) {
		NSDictionary *section = [self sectionAtIndex:i];
		if ([[section objectForKey:kRCRestKeySectionIdentifier] isEqualToString:sectionIdentifier]){
			return i;
		}
	}
	return NSNotFound;
}

- (NSInteger)indexOfRowWithIdentifier:(NSString*)rowIdentifier inSection:(NSInteger)section{
	for (int i = 0; i < [[self rowsInSection:section] count]; i++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
		NSDictionary *row = [self rowAtIndexPath:indexPath];
		if ([[row objectForKey:kRCRestKeyCellIdentifier] isEqualToString:rowIdentifier]){
			return i;
		}
	}
	return NSNotFound;
}

- (NSIndexPath*)indexPathOfRowWithIdentifier:(NSString*)cellIdentifier sectionIdentifier:(NSString*)sectionIdentifier{
	NSInteger section = sectionIdentifier ? [self indexOfSectionWithIdentifier:sectionIdentifier] : 0;
	if (section == NSNotFound) return nil;
	NSInteger row = [self indexOfRowWithIdentifier:cellIdentifier inSection:section];
	if (row == NSNotFound) return nil;
	return [NSIndexPath indexPathForItem:row inSection:section];
}
@end
