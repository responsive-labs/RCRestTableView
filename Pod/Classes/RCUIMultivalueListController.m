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

- (instancetype)initWithValues:(NSArray*)values selectedValue:(NSString*)selectedValue{
	self = [super initWithStyle:UITableViewStylePlain];
	if (self){
		self.values = values;
		self.selectedValue = selectedValue;
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
	cell.textLabel.text = [self.values objectAtIndex:indexPath.row];
	if ([[self.values objectAtIndex:indexPath.row] isEqualToString:self.selectedValue]) {
		[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
	}else{
		[cell setAccessoryType:UITableViewCellAccessoryNone];
	}
	return cell;
}


#pragma mark <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	self.selectedValue = [self.values objectAtIndex:indexPath.row];
	[self.tableView reloadData];
}

@end
