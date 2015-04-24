//
//  RCReactiveView.h
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import <Foundation/Foundation.h>

/// A protocol which is adopted by views which are backed by view models.
@protocol RCReactiveView <NSObject>

/// Binds the given view model to the view
- (void)bindViewModel:(id)viewModel;

@end
