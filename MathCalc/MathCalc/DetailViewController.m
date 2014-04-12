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
    undefinedAttributes = [self.shape undefinedAttributes].mutableCopy;
    
    
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
        //[self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)shapeDidCalculate:(Shape *)shape
{
    [self.tableView endUpdates];
}

- (void)shape:(Shape *)shape willDefineAttribute:(NSString *)attribute
{
    NSIndexPath *indexPath = [self indexPathForObject:attribute];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] inSection:0];
    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
    [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)shape:(Shape *)shape didUndefineAttribute:(NSString *)attribute
{
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Defined Attributes", @"Defined Attributes");
    } else if (section == 1) {
        return NSLocalizedString(@"Calculated Attributes", @"Calculated Attributes");
    } else if (section == 2) {
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
    
    [self.tableView beginUpdates];
    [self.shape defineAttribute:string];
    [self.shape calculate];
    [self.tableView endUpdates];
}

#pragma mark - Helpers

- (NSMutableArray *)arrayForSection:(NSInteger)section
{
    if (section == 0) {
        return self.shape.definedAttributes;
    } else if (section == 1) {
        return self.shape.calculatedAttributes;
    } else if (section == 2) {
        return self.shape.undefinedAttributes;
    }
    return nil;
}

- (NSInteger)sectionForArray:(NSMutableArray *)array
{
    if (array == self.shape.definedAttributes) {
        return 0;
    }
    else if (array == self.shape.calculatedAttributes) {
        return 1;
    }
    else if (array == self.shape.undefinedAttributes) {
        return 2;
    }
    return 0;
}

- (NSMutableArray *)arrayForObject:(id)object
{
    if ([self.shape.definedAttributes containsObject:object]) {
        return self.shape.definedAttributes;
    }
    else if ([self.shape.calculatedAttributes containsObject:object]) {
        return self.shape.calculatedAttributes;
    }
    else if ([self.shape.undefinedAttributes containsObject:object]) {
        return self.shape.undefinedAttributes;
    }
    return nil;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self arrayForSection:indexPath.section][indexPath.row];
}

- (NSIndexPath *)indexPathForObject:(id)object
{
    NSMutableArray *array = [self arrayForObject:object];
    return [NSIndexPath indexPathForRow:[array indexOfObject:object] inSection:[self sectionForArray:array]];
}


@end
