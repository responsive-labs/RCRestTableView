//
//  RCRestTableStructureTests.m
//  RCRestTableView
//
//  Created by Luca Serpico on 28/04/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

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
});

SpecEnd
