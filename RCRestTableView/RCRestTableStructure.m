// RCRestTableStructure.m
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
