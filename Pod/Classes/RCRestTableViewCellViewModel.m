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
#import "UIImage+RCRestTableView.h"
#import "RCRestTableViewTypes.h"

@interface RCRestTableViewCellViewModel()
@property (nonatomic,readwrite) NSString *type;
@property (nonatomic,readwrite) NSString *title;
@property (nonatomic,readwrite) NSString *cellIdentifier;
@property (nonatomic,readwrite) NSString *userIdentifier;
@property (nonatomic,readwrite) CGFloat cellHeight;
@property (nonatomic,readwrite) NSMutableDictionary *cellProperties;
@property (nonatomic,readwrite) NSMutableDictionary *typeProperties;
@end

@implementation RCRestTableViewCellViewModel

- (instancetype)initWithStructure:(NSDictionary*)structure identifier:(NSString *)identifier{
	self = [super init];
	if (self) {
		/** This assume that is already a correct structure */
		self.type = [structure objectForKey:kRCRestKeyCellType];
		self.title = [structure objectForKey:kRCRestKeyCellTitle];
		self.cellIdentifier = identifier;
		
		if (![[structure objectForKey:kRCRestKeyCellValue] isKindOfClass:[NSNull class]])
			self.value = [structure objectForKey:kRCRestKeyCellValue];
		
		// If is an UIImageCell convert the string in UIImage if possible
		if ([self.type isEqualToString:kRCRestTableViewCellTypeUIImageView]) {
			self.value = [UIImage findImageWithValue:self.value];
		}
		
		self.values = [structure objectForKey:kRCRestKeyCellValues];
		self.cellHeight = [structure objectForKey:kRCRestKeyCellHeight] ? [[structure objectForKey:kRCRestKeyCellHeight] floatValue] : kRCDefaultCellHeight;
		self.userIdentifier = [structure objectForKey:kRCRestKeyCellIdentifier];
		
		NSMutableDictionary *mutableStructure = [[NSMutableDictionary alloc] initWithDictionary:structure];
		[mutableStructure removeObjectForKey:kRCRestKeyCellType];
		[mutableStructure removeObjectForKey:kRCRestKeyCellTitle];
		[mutableStructure removeObjectForKey:kRCRestKeyCellValue];
		
		self.cellProperties = [NSMutableDictionary new];
		self.typeProperties = [NSMutableDictionary new];
		
		for (NSString *key in [mutableStructure allKeys]) {
			NSArray *pathComponents = [key componentsSeparatedByString:@"."];
			if ([pathComponents count] > 2) continue; // Currently we support only the first node
			
			if ([pathComponents count] == 1) {
				// Is a cell property
				NSString *selectorString = [NSString stringWithFormat:@"set%@:",[key uppercaseFirstLetter]];
				if ([[UITableViewCell class] instancesRespondToSelector:NSSelectorFromString(selectorString)]) {
					[self.cellProperties setValue:[mutableStructure objectForKey:key] forKey:selectorString];
				}
			}else if([pathComponents count] == 2 && [pathComponents[0] isEqualToString:self.type]){
				// Is a type property
				Class className = NSClassFromString(self.type);
				NSString *selectorString = [NSString stringWithFormat:@"set%@:",[pathComponents[1] uppercaseFirstLetter]];
				if ([[className class] instancesRespondToSelector:NSSelectorFromString(selectorString)]) {
					[self.typeProperties setValue:[mutableStructure objectForKey:key] forKey:selectorString];
				}
			}
		}
	}
	return self;
}
@end
