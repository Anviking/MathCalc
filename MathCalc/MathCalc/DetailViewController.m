//
//  DetailViewController.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "DetailViewController.h"
#import "Shape.h"
#import "BackgroundView.h"
#import "AttributeTableViewCell.h"
#import "BlurView.h"

@interface DetailViewController () <ShapeDelegate, AttributeTableViewCellDelegate>
@property (nonatomic, strong) UILongPressGestureRecognizer *previewGestureRecognizer;
@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) NSMutableArray *groupedAttributes;
@property (nonatomic, strong) NSMutableDictionary *originalSections;
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

- (UIColor *)backgroundViewOverlayColor
{
    return [UIColor colorWithWhite:0.0 alpha:0.2];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    [self.tableView reloadData];
    self.tableView.backgroundView = [UIView new];
    self.groupedAttributes = [[self.shape class] groupedAttributes].mutableCopy;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.originalSections = [NSMutableDictionary dictionary];
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
    for (NSArray *group in self.groupedAttributes) {
        for (NSString *attribute in group) {
            NSIndexPath *indexPath = [self indexPathForObject:attribute];
            AttributeTableViewCell *cell = (AttributeTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [self configureCell:cell atIndexPath:indexPath];
        }
    }
    [self.tableView endUpdates];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupedAttributes.count;
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
    NSString *attribute = [self objectAtIndexPath:indexPath];
    cell.attributeLabel.text = NSLocalizedString(attribute, nil);
    
    if (!self.editing) {
        NSString *value = [[self.shape valueForKeyPath:attribute] string];
        cell.textField.text = value;
    }
    
    if ([self.shape.definedAttributes containsObject:attribute]) {
        cell.defined = YES;
    } else {
        cell.defined = NO;
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
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (BOOL)attributeTableViewCellShouldBeginEditing:(AttributeTableViewCell *)cell
{
    return YES;
}

- (void)attributeTableViewCellDidChange:(AttributeTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *attribute = [self objectAtIndexPath:indexPath];
    NSNumber *number = [[NSNumber numberFormatter] numberFromString:cell.textField.text];
    
    [self.shape defineAttribute:attribute];
    [self.shape setValue:number forKey:attribute];
    [self.shape calculate];
}

#pragma mark - Helpers

- (NSArray *)arrayForSection:(NSInteger)section
{
    return self.groupedAttributes[section];
}

- (NSInteger)sectionForArray:(NSArray *)array
{
    return [self.groupedAttributes indexOfObject:array];
}

- (NSArray *)arrayForObject:(id)object
{
    for (NSArray *array in self.groupedAttributes) {
        if ([array containsObject:object]) {
            return array;
        }
    }
    return nil;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self arrayForSection:indexPath.section][indexPath.row];
}

- (NSIndexPath *)indexPathForObject:(id)object
{
    NSArray *array = [self arrayForObject:object];
    return [NSIndexPath indexPathForRow:[array indexOfObject:object] inSection:[self sectionForArray:array]];
}


@end
