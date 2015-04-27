//
//  RCRestTableViewCell.h
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import <UIKit/UIKit.h>
#import "RCReactiveView.h"

/**
 *  Superclass for all Rest table view cell
 *  Map viewModel cellProperties
 */

@interface RCRestTableViewCell : UITableViewCell <RCReactiveView>


+ (NSString*)cellIdentifier;
- (UITableView*)tableView;

- (void)bindViewModel:(RCRestTableViewCellViewModel*)viewModel NS_REQUIRES_SUPER;


@end
