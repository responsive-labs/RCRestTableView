//
//  RCRestTableViewController.h
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import <UIKit/UIKit.h>

@interface RCRestTableViewController : UITableViewController

- (instancetype)initWithJsonString:(NSString*)json;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end
