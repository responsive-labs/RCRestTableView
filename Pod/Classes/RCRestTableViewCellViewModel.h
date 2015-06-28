//
//  RCTableViewCellViewModel.h
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import <Foundation/Foundation.h>

/**
 *  Is a generic Table view cell model
 *	type contains the cell format : [UILabel,UITextField....]
 *	title contains the label title
 *	cellProperties contains all cell properties in a dictionary [aSelectorString,value]
 *	typeProperties contains all type properties in a dictionary [aSelectorString,value]
 *
 *	Note:
 *	The value for the selector is not verified
 */

@interface RCRestTableViewCellViewModel : NSObject

@property (nonatomic,readonly) NSString *type;
@property (nonatomic,readonly) NSString *title;
@property (nonatomic) id value;
@property (nonatomic,readwrite) NSMutableArray *values;
@property (nonatomic,readonly) NSString *cellIdentifier;
@property (nonatomic,readonly) NSString *userIdentifier;
@property (nonatomic,readonly) CGFloat cellHeight;
@property (nonatomic,readonly) NSDictionary *cellProperties;
@property (nonatomic,readonly) NSDictionary *typeProperties;
	
- (instancetype)initWithStructure:(NSDictionary*)structure identifier:(NSString*)identifier;

/**
 *  Set a new cell property with key
 *
 *  @param key   The key
 *  @param value The value
 *	@note require [UITableView reloadData]
 */
- (void)setPropertyWithKey:(NSString*)key value:(id)value;

@end
