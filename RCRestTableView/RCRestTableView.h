// RCRestTableView.h
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

#import <UIKit/UIKit.h>
#import "RCRestTableViewTypes.h"
#import "RCRestTableViewKeys.h"

@interface RCRestTableView : UITableView

/**
 *  Init table view with a json string
 *
 *  @param json The json string
 *
 *  @return An instance type of RCRestTableView
 */
- (instancetype)initWithJsonString:(NSString*)json;

/**
 *  Init table view with a NSDictionary
 *
 *  @param dictionary The dictionary
 *
 *  @return An instance type of RCRestTableView
 */
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

/**
 *  Setup a RCRestTableView with a json string
 *
 *  @param json The json
 *	@note  You can use this method when creating the table from the storyboard
 */
- (void)setJsonStructure:(NSString*)json;

/**
 *  Setup a RCRestTableView with a NSDictionary
 *
 *  @param dictionary The dictionary
 *	@note  You can use this method when creating the table from the storyboard
 */
- (void)setDictionaryStructure:(NSDictionary*)dictionary;

/**
 *  Set a property programmatically.
 *
 *  @param value             The property value
 *	@param key							 The key
 *  @param cellIdentifier    The cell identifier
 *  @param sectionIdentifier The section identifier
 *	
 *	@attention cellIdentifier must be not nil, sectionIdentifier can be nil instead
 *	@attention type, identifier are not supported
 *	@note sectionIdentifier can be nil only when the table has only one section
 *
 *  @throws NSInvalidArgumentException
 */
- (void)setPropertyValue:(id)value withKey:(NSString *)key forCellIdentifier:(NSString *)cellIdentifier withSectionIdentifier:(NSString *)sectionIdentifier;

/**
 *  Get the current fields values where the property `identifier` is specified.
 *
 *  @return A dictionary with the values, where the key reflect the property `identifier` and value is the current value of the field
 */
- (NSDictionary*)values;

/**
 *  Set fields values with a Key/Value dictionary where the key is the cell identifier and the value is the value specified.
 *
 *  @param values A dictionary with values
 *  @attention This method uses the same logic of the getter above.
 *	@note You can use this method instead of `setPropertyValue:withKey:forCellIdentifier:withSectionIdentifier:` if you want to set more values at the same time.
 */
- (void)setValues:(NSDictionary*)values;

@end
