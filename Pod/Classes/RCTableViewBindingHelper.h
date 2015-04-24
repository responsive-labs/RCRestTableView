//
//  RCTableViewBindingHelper.h
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RCRestTableViewViewModel;

@interface RCTableViewBindingHelper : NSObject

+ (instancetype)bindingHelperForTableView:(UITableView *)tableView
								viewModel:(RCRestTableViewViewModel*)viewModel;

@end
