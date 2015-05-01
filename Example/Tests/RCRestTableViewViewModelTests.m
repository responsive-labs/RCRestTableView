//
//  RCRestTableVIewViewModelTests.m
//  RCRestTableView
//
//  Created by Luca Serpico on 01/05/2015.
//  Copyright (c) 2015 Luca Serpico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import "RCRestTableViewViewModel.h"
#import "RCRestTableViewKeys.h"
#import "NSDictionary+RCRestTableView.h"
#import "RCRestTableViewCellViewModel.h"
#import "RCRestTableViewCellAvailable.h"

SpecBegin(RCRestTableViewViewModel)

describe(@"RCRestTableViewViewModel", ^{
	__block RCRestTableViewViewModel *viewModel;
	beforeAll(^{
		NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
		NSString *jsonPath = [testBundle pathForResource:@"jsonTestFile" ofType:@"json"];
		NSString *json = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:NULL];
		NSDictionary *dictionary = [NSDictionary initWithJsonString:json];
		viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
	});
	
	it(@"numberOfSections", ^{
		expect([viewModel numberOfSections]).to.equal(2);
	});
	
	it(@"numberOfRowsInSection", ^{
		expect([viewModel numberOfRowsInSection:0]).to.equal(3);
		expect([viewModel numberOfRowsInSection:1]).to.equal(1);
	});
	
	it(@"titleForHeaderInSection", ^{
		expect([viewModel titleForHeaderInSection:0]).to.equal(@"section header name 1");
		expect([viewModel titleForHeaderInSection:1]).to.equal(@"section header name 2");
	});
	
	it(@"titleForFooterInSection", ^{
		expect([viewModel titleForFooterInSection:0]).to.equal(@"section footer name 1");
		expect([viewModel titleForFooterInSection:1]).to.equal(@"section footer name 2");
	});
	
	it(@"heightForRowAtIndexPath", ^{
		NSIndexPath *indexPath0_0 = [NSIndexPath indexPathForItem:0 inSection:0];
		NSIndexPath *indexPath0_1 = [NSIndexPath indexPathForItem:1 inSection:0];
		
		expect([viewModel heightForRowAtIndexPath:indexPath0_0]).to.equal(kRCDefaultCellHeight);
		expect([viewModel heightForRowAtIndexPath:indexPath0_1]).to.equal(50);
	});
	
	it(@"viewModelForRowAtIndexPath", ^{
		NSIndexPath *indexPath0_0 = [NSIndexPath indexPathForItem:0 inSection:0];
		NSIndexPath *indexPath0_2 = [NSIndexPath indexPathForItem:2 inSection:0];
		RCRestTableViewCellViewModel *cvm0_0 = [viewModel viewModelForRowAtIndexPath:indexPath0_0];
		RCRestTableViewCellViewModel *cvm0_2 = [viewModel viewModelForRowAtIndexPath:indexPath0_2];
		
		expect(cvm0_0.cellIdentifier).to.equal([RCUILabelCell cellIdentifier]);
		expect(cvm0_2.cellIdentifier).to.equal([RCUITextFieldCell cellIdentifier]);
	});
});

SpecEnd