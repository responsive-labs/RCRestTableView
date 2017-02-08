// RCRestTableStructure.h
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

#import <Foundation/Foundation.h>

@interface RCRestTableStructure : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

- (NSArray*)sections;
- (NSDictionary*)sectionAtIndex:(NSInteger)section;
- (NSArray*)rowsInSection:(NSInteger)section;
- (NSDictionary*)rowAtIndexPath:(NSIndexPath*)indexPath;

/**
 *  Get index of section with identifier
 *
 *  @return the section index or NSNotFound
 */
- (NSInteger)indexOfSectionWithIdentifier:(NSString*)sectionIdentifier;

/**
 *  Get index of row with identifier in section
 *
 *  @return the row index or NSNotFound
 */
- (NSInteger)indexOfRowWithIdentifier:(NSString*)rowIdentifier inSection:(NSInteger)section;

- (NSIndexPath*)indexPathOfRowWithIdentifier:(NSString*)cellIdentifier sectionIdentifier:(NSString*)sectionIdentifier;

@end
