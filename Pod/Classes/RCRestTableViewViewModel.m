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
	if ([self.lazyViewModels objectForKey:indexPath])
		return [self.lazyViewModels objectForKey:indexPath];
	
	NSDictionary *row = [self.structure rowAtIndexPath:indexPath];
	
	NSString *type = [row objectForKey:kRCRestKeyCellType];
	RCRestTableViewCellViewModel *cellViewModel;
	
	if ([type isEqualToString:kRCRestTableViewCellTypeUIILabel]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUILabelCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeUITextField]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUITextFieldCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeUIImageView]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUIImageViewCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeUISwitch]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCUISwitchCell cellIdentifier]];
	}else if ([type isEqualToString:kRCRestTableViewCellTypeMultivalue]){
		cellViewModel = [[RCRestTableViewCellViewModel alloc] initWithStructure:row identifier:[RCMultivalueCell cellIdentifier]];
	}
	
	[self.lazyViewModels setObject:cellViewModel forKey:indexPath];
	return cellViewModel;
	
}

- (NSDictionary*)values{
	NSMutableDictionary *values = [NSMutableDictionary new];
	for (RCRestTableViewCellViewModel *cellViewModel in [self.lazyViewModels allValues]) {
		if ([cellViewModel userIdentifier]) {
			[values setObject:cellViewModel.value forKey:cellViewModel.userIdentifier];
		}
	}
	return values;
}

@end
