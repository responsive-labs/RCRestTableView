// NSValue+RCRestTableVIew.m
// Copyright (c) 2015 Research Central (http://www.researchcentral.co/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSValue+RCRestTableVIew.h"

#define CStringEquals(stringA, stringB) (stringA == stringB || strcmp(stringA, stringB) == 0)

@implementation NSValue (RCRestTableVIew)

- (void)setAsArgumentForInvocation:(NSInvocation *)invocation atIndex:(NSUInteger)index
{
	const char *argumentType = [[invocation methodSignature] getArgumentTypeAtIndex:index];
	
	if (CStringEquals(argumentType, @encode(id))) {
		id selfRef = self;
		[invocation setArgument:&selfRef atIndex:index];
	}
	else { //argument is primitive
		NSUInteger argumentSize;
		NSGetSizeAndAlignment(argumentType, &argumentSize, NULL);
		
		const char *valueType = [self objCType];
		if (!CStringEquals(valueType, argumentType)) {
			NSUInteger valueSize;
			NSGetSizeAndAlignment(valueType, &valueSize, NULL);
			NSAssert(valueSize <= argumentSize, @"Trying to inject NSValue with type of different size ('%s' expected, but '%s' passed)", argumentType, valueType);
		}
		
		void *buffer = alloca(argumentSize);
		
		[self getValue:buffer];
		[invocation setArgument:buffer atIndex:index];
	}
}

@end

@implementation NSNumber (RCRestTableVIew)

- (void)setAsArgumentForInvocation:(NSInvocation *)invocation atIndex:(NSUInteger)index
{
	const char *argumentType = [[invocation methodSignature] getArgumentTypeAtIndex:index];
	
	/** Doing this type switching below because when we call NSNumber's methods like 'doubleValue' or 'floatValue',
	 * value will be converted if necessary. (instead of approach when we just copy bytes - see NSValue category above)
	 * That will handle situation when for example argumentType is float, but NSNumber's type is double */
	
	if (CStringEquals(argumentType, @encode(id))) {
		id converted = self;
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(int))) {
		int converted = [self intValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(unsigned int))) {
		unsigned int converted = [self unsignedIntValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(char))) {
		char converted = [self charValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(unsigned char))) {
		unsigned char converted = [self unsignedCharValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(bool))) {
		bool converted = [self boolValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(short))) {
		short converted = [self shortValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(unsigned short))) {
		unsigned short converted = [self unsignedShortValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(float))) {
		float converted = [self floatValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(double))) {
		double converted = [self doubleValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(long))) {
		long converted = [self longValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(unsigned long))) {
		unsigned long converted = [self unsignedLongValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(long long))) {
		long long converted = [self longLongValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else if (CStringEquals(argumentType, @encode(unsigned long long))) {
		unsigned long long converted = [self unsignedLongLongValue];
		[invocation setArgument:&converted atIndex:index];
	}
	else {
		[NSException raise:@"InvalidNumberType" format:@"Invalid Number: Type '%s' is not supported.", argumentType];
	}
}

@end

@implementation NSString (RCRestTableVIew)

- (void)setAsArgumentForInvocation:(NSInvocation *)invocation atIndex:(NSUInteger)index
{
	const char *argumentType = [[invocation methodSignature] getArgumentTypeAtIndex:index];
	
	if (CStringEquals(argumentType, @encode(id))) {
		id converted = self;
		[invocation setArgument:&converted atIndex:index];
	}
}

@end
