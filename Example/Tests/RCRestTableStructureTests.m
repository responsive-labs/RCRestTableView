//
//  RCRestTableStructureTests.m
//  RCRestTableView
//
//  Created by Luca Serpico on 28/04/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import "RCRestTableStructure.h"
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>

SpecBegin(RCRestTableStructure)

describe(@"Structure", ^{
	__block RCRestTableStructure *structure;
	beforeAll(^{
		NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
		NSString *jsonPath = [testBundle pathForResource:@"jsonTestFile" ofType:@"json"];
		NSString *json = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
		structure = [[RCRestTableStructure alloc] initWithJsonString:json];
	});
	
	it(@"sections", ^{
		expect([[structure sections] count]).to.equal(2);
	});
	
	it(@"rows in section", ^{
		expect([[structure rowsInSection:0] count]).to.equal(3);
		expect([[structure rowsInSection:1] count]).to.equal(1);
	});
});

SpecEnd
