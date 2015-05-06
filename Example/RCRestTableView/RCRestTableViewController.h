//
//  RCRestTableViewController.h
//  RCRestTableView
//
//  Created by Luca Serpico on 06/05/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCRestTableViewController : UITableViewController

- (instancetype)initWithJsonString:(NSString*)json;

@end
