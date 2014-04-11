//
//  DetailViewController.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "DetailViewController.h"
#import "Shape.h"

@interface DetailViewController () {
    NSMutableArray *definedAttributes;
    NSMutableArray *undefinedAttributes;
}
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setShape:(Shape *)shape
{
    if (_shape != shape) {
        _shape = shape;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    definedAttributes = [self.shape definedAttributes].mutableCopy;
    undefinedAttributes = [self.shape undefindedAttributes].mutableCopy;
    
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Known Attributes", @"Known Attributes");
    } else if (section == 1) {
        return NSLocalizedString(@"Not Known Attributes", @"Not Known Attributes");
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self arrayForSection:section].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *string = [self objectAtIndexPath:indexPath];
    cell.textLabel.text = string;
    
    return cell;
}

#pragma mark - Helpers

- (NSMutableArray *)arrayForSection:(NSInteger)section
{
    if (section == 0) {
        return definedAttributes;
    } else if (section == 1) {
        return undefinedAttributes;
    }
    return nil;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self arrayForSection:indexPath.section][indexPath.row];
}

@end
