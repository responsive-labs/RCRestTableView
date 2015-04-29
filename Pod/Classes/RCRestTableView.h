//
//  RCRestTableView.h
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import <UIKit/UIKit.h>

@interface RCRestTableView : UITableView

- (instancetype)initWithJsonString:(NSString*)json;
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
