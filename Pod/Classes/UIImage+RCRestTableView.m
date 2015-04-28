//
//  UIImage+RCRestTableView.m
//  Pods
//
//  Created by Luca Serpico on 27/04/2015.
//
//

#import "UIImage+RCRestTableView.h"

@implementation UIImage (RCRestTableView)

+ (UIImage*)findImageWithValue:(id)value{
	if ([value isKindOfClass:[UIImage class]])
		return value;
	if ([value isKindOfClass:[NSString class]] && [value length] >0) {
		UIImage *image;
		// Check if the image is in the bundle
		image = [UIImage imageNamed:value];
		if (image) return image;
		
		// Check if the image is in the documents directory
		NSString *imagePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",value];
		image = [self imageAtPath:imagePath];
		if (image) return image;
		
		// Check if the image is in the temporary directory
		imagePath = [NSTemporaryDirectory() stringByAppendingFormat:@"/%@",value];
		image = [self imageAtPath:imagePath];
		if (image) return image;
	}
	return nil;
}

+ (UIImage*)imageAtPath:(NSString*)path{
	NSData *data= [NSData dataWithContentsOfFile:path];
	return data ? [UIImage imageWithData:data] : nil;
}

@end
