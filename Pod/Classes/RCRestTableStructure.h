//
//  RCRestTableStructure.h
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

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
