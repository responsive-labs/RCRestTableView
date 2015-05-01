//
//  RCRestTableViewViewModel.h
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import <Foundation/Foundation.h>

@class RACCommand,RACSignal,RCRestTableViewCellViewModel;

@interface RCRestTableViewViewModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (RCRestTableViewCellViewModel*)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSString *)titleForFooterInSection:(NSInteger)section;

@end