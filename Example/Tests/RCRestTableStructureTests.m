// RCRestTableStructureTests.m
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

#import <UIKit/UIKit.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "RCRestTableStructure.h"
#import "RCRestTableViewKeys.h"
#import "NSDictionary+RCRestTableView.h"

SpecBegin(RCRestTableStructure)

describe(@"Structure", ^{
	__block RCRestTableStructure *structure;
	beforeAll(^{
		NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
		NSString *jsonPath = [testBundle pathForResource:@"jsonTestFile" ofType:@"json"];
		NSString *json = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
		NSDictionary *dictionary = [NSDictionary initWithJsonString:json];
		structure = [[RCRestTableStructure alloc] initWithDictionary:dictionary];
	});
	
	it(@"sections", ^{
		expect([[structure sections] count]).to.equal(2);
	});
	
	it(@"rows in section", ^{
		expect([[structure rowsInSection:0] count]).to.equal(3);
		expect([[structure rowsInSection:1] count]).to.equal(1);
	});
	
	it(@"section at index", ^{
		NSDictionary *fromSections = [[structure sections] objectAtIndex:0];
		NSDictionary *fromStructure = [structure sectionAtIndex:0];
		expect(fromSections).to.equal(fromStructure);
	});
	
	it(@"row at indexPath", ^{
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
		NSDictionary *fromSections = [[[structure sectionAtIndex:indexPath.section] objectForKey:kRCRestKeyRows] objectAtIndex:indexPath.row];
		NSDictionary *fromStructure = [structure rowAtIndexPath:indexPath];
		expect(fromSections).to.equal(fromStructure);
	});
	
	it(@"empty dictionary", ^{
		RCRestTableStructure *emptyStructure = [[RCRestTableStructure alloc] initWithDictionary:@{}];
		expect([emptyStructure sections]).to.beNil();
		expect([emptyStructure rowsInSection:0]).to.beNil();
	});
});

SpecEnd
