// RCTableViewCellViewModel.h
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
