//
//  DetailViewController.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "DetailViewController.h"
#import "Shape.h"
#import "AttributeTableViewCell.h"

@interface DetailViewController () <ShapeDelegate, AttributeTableViewCellDelegate>
@end

@implementation DetailViewController {
    NSIndexPath *indexPathToDefine, *indexPathToUndefine;
}

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
    [self.shape reset];
    [self.tableView reloadData];
}

#pragma mark - Shape Delegate

- (void)shapeWillCalculate:(Shape *)shape
{
    [self.tableView beginUpdates];
}

- (void)shapeDidCalculate:(Shape *)shape
{
    indexPathToDefine = nil;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)shape:(Shape *)shape willDefineAttribute:(NSString *)attribute
{
    indexPathToDefine = [self indexPathForObject:attribute];
}


- (void)shape:(Shape *)shape didDefineAttribute:(NSString *)attribute
{
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:shape.definedAttributes.count - 1 inSection:0];
    [self.tableView moveRowAtIndexPath:indexPathToDefine toIndexPath:newIndexPath];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathToDefine];
    [self configureCell:(AttributeTableViewCell *)cell atIndexPath:newIndexPath];
}

- (void)shape:(Shape *)shape willUndefineAttribute:(NSString *)attribute
{
    indexPathToUndefine = [self indexPathForObject:attribute];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathToUndefine];
    [self configureCell:(AttributeTableViewCell *)cell atIndexPath:indexPathToUndefine];
}

- (void)shape:(Shape *)shape didUndefineAttribute:(NSString *)attribute
{
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView moveRowAtIndexPath:indexPathToUndefine toIndexPath:newIndexPath];
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
    AttributeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(AttributeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = [self objectAtIndexPath:indexPath];
    cell.textLabel.text = string;
    NSString *value = [[self.shape valueForKeyPath:string] string];
    cell.textField.text = value;
    
    if (indexPath.section == 1 && cell.textField.text.length > 0) {
        cell.userInteractionEnabled = NO;
    } else {
        cell.userInteractionEnabled = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttributeTableViewCell *cell = (AttributeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.textField becomeFirstResponder];
}

#pragma mark - AttributeTableViewCellDelegate

- (void)attributeTableViewCellDidBeginEditing:(AttributeTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *string = [self objectAtIndexPath:indexPath];
    

    [self.tableView beginUpdates];
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.shape defineAttribute:string];
    [self.tableView endUpdates];
}

- (BOOL)attributeTableViewCellShouldBeginEditing:(AttributeTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *string = [self objectAtIndexPath:indexPath];
    NSNumber *number = [self.shape valueForKey:string];
    
    return !(number && indexPath.section == 1);
}

- (void)attributeTableViewCellDidChange:(AttributeTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *attribute = [self objectAtIndexPath:indexPath];
    NSNumber *number = [[NSNumber numberFormatter] numberFromString:cell.textField.text];
    [self.shape setValue:number forKey:attribute];
    [self.shape calculate];
}

#pragma mark - Helpers

- (NSMutableArray *)arrayForSection:(NSInteger)section
{
    if (section == 0) {
        return self.shape.definedAttributes;
    } else if (section == 1) {
        return self.shape.undefinedAttributes;
    }
    return nil;
}

- (NSInteger)sectionForArray:(NSMutableArray *)array
{
    if (array == self.shape.definedAttributes) {
        return 0;
    }
    else if (array == self.shape.undefinedAttributes) {
        return 1;
    }
    return 0;
}

- (NSMutableArray *)arrayForObject:(id)object
{
    if ([self.shape.definedAttributes containsObject:object]) {
        return self.shape.definedAttributes;
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
