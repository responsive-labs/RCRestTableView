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
@property (nonatomic) NSString *value;
@property (nonatomic,readonly) NSString *cellIdentifier;
@property (nonatomic,readonly) NSDictionary *cellProperties;
@property (nonatomic,readonly) NSDictionary *typeProperties;
	
- (instancetype)initWithStructure:(NSDictionary*)structure identifier:(NSString*)identifier;

@end
