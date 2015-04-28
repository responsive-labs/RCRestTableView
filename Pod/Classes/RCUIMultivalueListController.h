//
//  RCUIMultivalueListController.h
//  Pods
//
//  Created by Luca Serpico on 28/04/2015.
//
//

#import <UIKit/UIKit.h>

@interface RCUIMultivalueListController : UITableViewController

@property (nonatomic,strong) NSString *selectedValue;

- (instancetype)initWithValues:(NSArray*)values selectedValue:(NSString*)selectedValue;

@end
