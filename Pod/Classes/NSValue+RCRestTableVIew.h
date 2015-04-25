//
//  NSValue+RCRestTableVIew.h
//  Pods
//
//  Created by Luca Serpico on 24/04/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSValue (RCRestTableVIew)

- (void)setAsArgumentForInvocation:(NSInvocation *)invocation atIndex:(NSUInteger)index;

@end
