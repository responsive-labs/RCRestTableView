//
//  RCRestTableView.m
//  Pods
//
//  Created by Luca Serpico on 23/04/2015.
//
//

#import "RCRestTableView.h"
#import "NSDictionary+RCRestTableView.h"
#import "RCRestTableViewViewModel.h"
#import "RCTableViewBindingHelper.h"

@interface RCRestTableView ()
@property (nonatomic,strong) RCTableViewBindingHelper *bindingHelper;
@property (nonatomic,strong) RCRestTableViewViewModel *viewModel;
@end

@implementation RCRestTableView


- (instancetype)initWithJsonString:(NSString*)json{
	self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	if (self) {
		NSDictionary *dictionary = [NSDictionary initWithJsonString:json];
		if (!dictionary) [NSException raise:@"Invalid json format" format:@"Please provide a correct json"];

		self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
		self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	}
	return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dictionary{
	self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	if (self) {
		self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
		self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	}
	return self;
}

#pragma mark - Actions
- (void)setJsonStructure:(NSString*)json{
	NSDictionary *dictionary = [NSDictionary initWithJsonString:json];
	if (!dictionary) [NSException raise:@"Invalid json format" format:@"Please provide a correct json"];
	self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
	self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	[self reloadData];
}

- (void)setDictionaryStructure:(NSDictionary*)dictionary{
	self.viewModel = [[RCRestTableViewViewModel alloc] initWithDictionary:dictionary];
	self.bindingHelper = [RCTableViewBindingHelper bindingHelperForTableView:self viewModel:self.viewModel];
	[self reloadData];
}

- (NSDictionary*)values{
	return [self.viewModel values];
}

- (void)setValues:(NSDictionary*)values{
	[self.viewModel setValues:values];
	[self reloadData];
}
- (void)setMultivaluesItems:(NSArray*)items forCellIdentifier:(NSString*)identifier{
	[self.viewModel setMultivaluesItems:items forCellIdentifier:identifier];
	[self reloadData];
}
@end
