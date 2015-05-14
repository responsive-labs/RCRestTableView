//
//  RCRestTableViewViewModel.m
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import "RCRestTableViewViewModel.h"
#import "RCRestTableViewKeys.h"
#import "RCRestTableStructure.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
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
		self.structure = [[RCRestTableStructure alloc] initWithDictionary:dictionary];
		self.lazyViewModels = [NSMutableDictionary new];
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

- (NSDictionary*)values{
	NSMutableDictionary *values = [NSMutableDictionary new];
	
	for (NSInteger sectionIndex=0; sectionIndex<[[self.structure sections] count]; sectionIndex++) {
		NSDictionary *section = [self.structure sectionAtIndex:sectionIndex];
		NSString *sectionIdentifier = [section objectForKey:kRCRestKeySectionIdentifier];
		NSMutableDictionary *valuesInSection = [NSMutableDictionary new];
		
		for (NSInteger rowIndex=0; rowIndex<[[self.structure rowsInSection:sectionIndex] count]; rowIndex++) {
			RCRestTableViewCellViewModel *cellViewModel = [self viewModelForRowAtIndexPath:[NSIndexPath indexPathForItem:rowIndex inSection:sectionIndex]];
			if ([cellViewModel userIdentifier]) {
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

@end
