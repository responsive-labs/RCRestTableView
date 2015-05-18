//
//  RCRestTableView.h
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import <UIKit/UIKit.h>
#import "RCRestTableViewTypes.h"
#import "RCRestTableViewKeys.h"

@interface RCRestTableView : UITableView

- (instancetype)initWithJsonString:(NSString*)json;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

/**
 *  Get the current fields values where the property `identifier` is specified
 *
 *  @return A dictionary with the values, where the key reflect the property `identifier` and value is the current value of the field
 */
- (NSDictionary*)values;

/**
 *  Set fields values
 *
 *  @param values A dictionary with values
 */
- (void)setValues:(NSDictionary*)values;

@end
