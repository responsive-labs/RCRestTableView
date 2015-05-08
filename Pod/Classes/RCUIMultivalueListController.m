//
//  RCUIMultivalueListController.m
//  Pods
//
//  Created by Luca Serpico on 28/04/2015.
//
//

#import "RCUIMultivalueListController.h"

@interface RCUIMultivalueListController()

@property (nonatomic,strong) NSArray *values;

@end

@implementation RCUIMultivalueListController

- (instancetype)initWithValues:(NSArray*)values selectedKey:(NSString*)selectedkey{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self){
		self.values = values;
		self.selectedKey = selectedkey;
		[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
	}
	return self;
}

#pragma mark <UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.values count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	NSDictionary *row = [self.values objectAtIndex:indexPath.row];
	NSString *key = [[row allKeys] firstObject];
	NSString *value = [[row allValues] firstObject];
	
	cell.textLabel.text = value;
	
	if ([key isEqualToString:self.selectedKey]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}else{
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	return cell;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSDictionary *row = [self.values objectAtIndex:indexPath.row];
	NSString *key = [[row allKeys] firstObject];

	self.selectedKey = key;
	[self.tableView reloadData];
}

@end
