//
//  DetailViewController.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "DetailViewController.h"
#import "Shape.h"

@interface DetailViewController () <ShapeDelegate> {
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
        _shape.delegate = self;
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

- (IBAction)reset:(id)sender
{
    self.shape = [self.shape.class new];
}

#pragma mark - Shape Delegate

- (void)shapeWillCalculate:(Shape *)shape
{
    [self.tableView beginUpdates];
}

- (void)shape:(Shape *)shape didCalculateValue:(NSNumber *)number attribute:(NSString *)attribute
{
    if ([undefinedAttributes containsObject:attribute]) {
        NSArray *indexPaths = @[ [NSIndexPath indexPathForRow:[undefinedAttributes indexOfObject:attribute] inSection:1] ];
        [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)shapeDidCalculate:(Shape *)shape
{
    [self.tableView endUpdates];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Defined Attributes", @"Defined Attributes");
    } else if (section == 1) {
        return NSLocalizedString(@"Undefined Attributes", @"Undefined Attributes");
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
    NSString *value = [[self.shape valueForKeyPath:string] string];
    cell.detailTextLabel.text = value;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [self objectAtIndexPath:indexPath];
    [self.shape setValue:@10 forKey:string];
    
    if (indexPath.section == 1 && self.shape.undefindedAttributes.count) {
        [undefinedAttributes removeObject:string];
        [definedAttributes addObject:string];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[tableView numberOfRowsInSection:0] inSection:0];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
        [self.tableView reloadRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else if (indexPath.section == 1 && !self.shape.undefindedAttributes.count) {
        
        NSString *attributeToUndefine = definedAttributes.lastObject;
        [definedAttributes removeObject:attributeToUndefine];
        [definedAttributes addObject:string];

        undefinedAttributes[[undefinedAttributes indexOfObject:string]] = attributeToUndefine;
        
        [self.tableView beginUpdates];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[tableView numberOfRowsInSection:0] - 1  inSection:0];
        [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
        [self.tableView moveRowAtIndexPath:newIndexPath toIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
//        [self.tableView reloadRowsAtIndexPaths:@[ newIndexPathA, indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    }
    
    [self.shape calculate];
    //[self configureView];
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
