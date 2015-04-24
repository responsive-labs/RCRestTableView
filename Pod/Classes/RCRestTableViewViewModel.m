//
//  RCRestTableViewViewModel.m
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import "RCRestTableViewViewModel.h"
#import "RCRestTableViewKeys.h"
#import "NSDictionary+RCRestTableView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RCRestTableViewCellViewModel.h"

@interface RCRestTableViewViewModel()
@property (nonatomic,strong) NSDictionary *structure;
@end

@implementation RCRestTableViewViewModel

- (instancetype)initWithJsonString:(NSString*)json{
	self = [super init];
	if (self){
		self.structure = [NSDictionary initWithJsonString:json];
		NSLog(@"structure\n %@", self.structure);
		if (!self.structure) [NSException raise:@"Invalid json format" format:@"Please provide a correct json"];
	}
	return self;
}

- (NSInteger)numberOfSections{
	NSArray *sections = [self.structure objectForKey:kRCRestKeySections];
	return [sections count];
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
	NSArray *sections = [self.structure objectForKey:kRCRestKeySections];
	NSDictionary *currentSection = [sections objectAtIndex:section];
	NSArray *rows = [currentSection objectForKey:kRCRestKeyRows];
	return [rows count];
}
- (NSString *)titleForHeaderInSection:(NSInteger)section{
	NSArray *sections = [self.structure objectForKey:kRCRestKeySections];
	NSDictionary *currentSection = [sections objectAtIndex:section];
	return [currentSection objectForKey:kRCRestKeySectionHeader];
}
- (NSString *)titleForFooterInSection:(NSInteger)section{
	NSArray *sections = [self.structure objectForKey:kRCRestKeySections];
	NSDictionary *currentSection = [sections objectAtIndex:section];
	return [currentSection objectForKey:kRCRestKeySectionFooter];
}

- (id)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSArray *sections = [self.structure objectForKey:kRCRestKeySections];
	NSDictionary *currentSection = [sections objectAtIndex:indexPath.section];
	NSArray *rows = [currentSection objectForKey:kRCRestKeyRows];
	NSDictionary *row = [rows objectAtIndex:indexPath.row];
	
	NSString *type = [row objectForKey:kRCRestKeyCellType];
	RCRestTableViewCellViewModel *cellViewModel;
	
	return cellViewModel;
	
}

@end
