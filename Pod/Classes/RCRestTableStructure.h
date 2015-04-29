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

@end
