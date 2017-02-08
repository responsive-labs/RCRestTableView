// RCRestTableViewViewModel.m
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

#import "RCRestTableViewViewModel.h"
#import "RCRestTableViewKeys.h"
#import "RCRestTableStructure.h"
#import "RCRestTableViewCellViewModel.h"
#import "RCRestTableViewCellAvailable.h"
#import "RCRestTableViewTypes.h"

@interface RCRestTableViewViewModel()
@property (nonatomic,strong) RCRestTableStructure *structure;
@property (nonatomic,strong) NSMutableDictionary *lazyViewModels;
@end

@implementation RCRestTableViewViewModel

- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
	self = [super init];
	if (self){
		[self setDictionaryStructure:dictionary];
	}
	return self;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	RCRestTableViewCellViewModel *cellViewModel = [self viewModelForRowAtIndexPath:indexPath];
	return cellViewModel.cellHeight;
}

- (NSInteger)numberOfSections{
	return [[self.structure sections] count];
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
	return [[self.structure rowsInSection:section] count];
}
- (NSString *)titleForHeaderInSection:(NSInteger)section{
	return [[self.structure sectionAtIndex:section] objectForKey:kRCRestKeySectionHeader];
}
- (NSString *)titleForFooterInSection:(NSInteger)section{
	return [[self.structure sectionAtIndex:section] objectForKey:kRCRestKeySectionFooter];
}

- (id)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *indexPathKey = [NSString stringWithFormat:@"s%@r%@",@(indexPath.section),@(indexPath.row)];
	if ([self.lazyViewModels objectForKey:indexPathKey])
		return [self.lazyViewModels objectForKey:indexPathKey];
	
	NSDictionary *row = [self.structure rowAtIndexPath:indexPath];
	
	NSString *type = [row objectForKey:kRCRestKeyCellType];
	RCRestTableViewCellViewModel *cellViewModel;
	
	if ([type isEqualToString:kRCRestTableViewCellTypeUILabel]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUILabelCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeUITextField]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUITextFieldCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeUIImageView]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUIImageViewCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeUISwitch]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUISwitchCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeMultivalue]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCMultivalueCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeSZTextView]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCSZTextViewCell cellIdentifier]];
	}
	
	[self.lazyViewModels setObject:cellViewModel forKey:indexPathKey];
	return cellViewModel;
	
}

- (void)setDictionaryStructure:(NSDictionary*)structure{
	self.structure = [[RCRestTableStructure alloc] initWithDictionary:structure];
	self.lazyViewModels = [NSMutableDictionary new];
}

- (NSDictionary*)values{
	NSMutableDictionary *values = [NSMutableDictionary new];
	
	for (NSInteger sectionIndex=0; sectionIndex<[[self.structure sections] count]; sectionIndex++) {
		NSDictionary *section = [self.structure sectionAtIndex:sectionIndex];
		NSString *sectionIdentifier = [section objectForKey:kRCRestKeySectionIdentifier];
		NSMutableDictionary *valuesInSection = [NSMutableDictionary new];
		
		for (NSInteger rowIndex=0; rowIndex<[[self.structure rowsInSection:sectionIndex] count]; rowIndex++) {
			RCRestTableViewCellViewModel *cellViewModel = [self viewModelForRowAtIndexPath:[NSIndexPath indexPathForItem:rowIndex inSection:sectionIndex]];
			if ([cellViewModel userIdentifier] && [cellViewModel value]) {
				[valuesInSection setObject:cellViewModel.value forKey:cellViewModel.userIdentifier];
			}
		}
		if (sectionIdentifier){
			[values setObject:valuesInSection forKey:sectionIdentifier];
		}else{
			[values addEntriesFromDictionary:valuesInSection];
		}
	}
	
	return values;
}

- (void)setValues:(NSDictionary*)values{
	for (NSInteger sectionIndex=0; sectionIndex<[[self.structure sections] count]; sectionIndex++) {
		NSDictionary *section = [self.structure sectionAtIndex:sectionIndex];
		NSString *sectionIdentifier = [section objectForKey:kRCRestKeySectionIdentifier];
		NSDictionary *valuesForSection = [values objectForKey:sectionIdentifier] ?: values;
		
		for (NSInteger rowIndex=0; rowIndex<[[self.structure rowsInSection:sectionIndex] count]; rowIndex++) {
			RCRestTableViewCellViewModel *cellViewModel = [self viewModelForRowAtIndexPath:[NSIndexPath indexPathForItem:rowIndex inSection:sectionIndex]];
			if ([cellViewModel userIdentifier] && [valuesForSection objectForKey:[cellViewModel userIdentifier]]) {
				[cellViewModel setValue:[valuesForSection objectForKey:[cellViewModel userIdentifier]]];
			}
		}
	}
}
- (void)setMultivaluesItems:(NSArray*)items forCellIdentifier:(NSString*)identifier{
	for (NSInteger sectionIndex=0; sectionIndex<[[self.structure sections] count]; sectionIndex++) {		
		for (NSInteger rowIndex=0; rowIndex<[[self.structure rowsInSection:sectionIndex] count]; rowIndex++) {
			RCRestTableViewCellViewModel *cellViewModel = [self viewModelForRowAtIndexPath:[NSIndexPath indexPathForItem:rowIndex inSection:sectionIndex]];
			if ([[cellViewModel userIdentifier] isEqualToString:identifier] && [cellViewModel.cellIdentifier isEqualToString:[RCMultivalueCell cellIdentifier]]) {
				[cellViewModel setValues:[NSMutableArray arrayWithArray:items]];
			}
		}
	}
}
- (void)setPropertyValue:(id)value withKey:(NSString*)key forCellIdentifier:(NSString*)cellIdentifier withSectionIdentifier:(NSString*)sectionIdentifier{
	if (!key || !value)
		[NSException raise:NSInvalidArgumentException format:@"key and value must be not nil"];
	if (!cellIdentifier)
		[NSException raise:NSInvalidArgumentException format:@"cellIdentifier must be not nil"];
	if (!sectionIdentifier && [self numberOfSections]>1)
		[NSException raise:NSInvalidArgumentException format:@"cellIdentifier must be not nil"];
	
	NSIndexPath *indexPath = [self.structure indexPathOfRowWithIdentifier:cellIdentifier sectionIdentifier:sectionIdentifier];
	if (!indexPath)
		[NSException raise:NSInvalidArgumentException format:@"Row not found"];
	
	RCRestTableViewCellViewModel *cellViewModel = [self viewModelForRowAtIndexPath:indexPath];
	[cellViewModel setPropertyWithKey:key value:value];
}
@end
