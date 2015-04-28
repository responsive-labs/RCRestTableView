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

/** Gives a signal when new content is available */
@property (nonatomic,readonly) RACSignal *updateContentSignal;
/** Command to execute when a cell has been selected. */
@property (nonatomic,readonly) RACCommand *selection;

- (instancetype)initWithJsonString:(NSString*)json;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (RCRestTableViewCellViewModel*)viewModelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleForHeaderInSection:(NSInteger)section;
- (NSString *)titleForFooterInSection:(NSInteger)section;

@end