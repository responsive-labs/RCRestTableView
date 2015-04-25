//
//  RCTableViewCellViewModel.m
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import "RCRestTableViewCellViewModel.h"
#import "RCRestTableViewKeys.h"
#import <UIKit/UIKit.h>
#import "NSString+RCRestTableView.h"

@interface RCRestTableViewCellViewModel()
@property (nonatomic,readwrite) NSString *type;
@property (nonatomic,readwrite) NSString *title;
@property (nonatomic,readwrite) NSMutableDictionary *cellProperties;
@property (nonatomic,readwrite) NSMutableDictionary *typeProperties;
@end

@implementation RCRestTableViewCellViewModel

- (instancetype)initWithStructure:(NSDictionary*)structure{
	self = [super init];
	if (self) {
		/** This assume that is already a correct structure */
		self.type = [structure objectForKey:kRCRestKeyCellType];
		self.title = [structure objectForKey:kRCRestKeyCellTitle];
		
		NSMutableDictionary *mutableStructure = [[NSMutableDictionary alloc] initWithDictionary:structure];
		[mutableStructure removeObjectForKey:kRCRestKeyCellType];
		[mutableStructure removeObjectForKey:kRCRestKeyCellTitle];
		
		self.cellProperties = [NSMutableDictionary new];
		self.typeProperties = [NSMutableDictionary new];
		
		for (NSString *key in [mutableStructure allKeys]) {
			NSArray *pathComponents = [key pathComponents];
			if ([pathComponents count] > 2) continue; // Currently we support only the first node
			if ([pathComponents count] == 1) {
				// Is a cell property
				NSString *selectorString = [NSString stringWithFormat:@"set%@:",[key uppercaseFirstLetter]];
				if ([[UITableViewCell class] instancesRespondToSelector:NSSelectorFromString(selectorString)]) {
					[self.cellProperties setValue:[mutableStructure objectForKey:key] forKey:selectorString];
				}
			}else if([pathComponents count] == 1 && [pathComponents[0] isEqualToString:self.type]){
				// Is a type property
			}
		}
	}
	return self;
}
@end
