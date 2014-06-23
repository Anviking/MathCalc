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
@property (nonatomic, strong) NSIndexPath *editingIndexPath;
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
    return nil;
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
    
    NSInteger i = self.shape.minimumNumberOfAttributesRequired;
    
    switch (i) {
        case 1:
            self.detailDescriptionLabel.text = NSLocalizedString(@"Define one property", @"");
            break;
        case 2:
            self.detailDescriptionLabel.text = NSLocalizedString(@"Define two different properties", @"");
            break;
        case 3:
            self.detailDescriptionLabel.text = NSLocalizedString(@"Define three different properties", @"");
            break;
        default:
            break;
    }
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
    NSString *description = [self descriptionForAttribute:attribute];
    if (description && [indexPath isEqual:self.editingIndexPath]) {
         cell.descriptionTextLabel.text = description;
    }
    cell.attributeLabel.text = NSLocalizedString(attribute, nil);
    
    UnitFormatter *formatter = [[self.shape formatterClassForAttribute:attribute] defaultFormatter];
    cell.unitLabel.text = formatter.unit;
    
    if (!cell.textField.editing) {
        NSString *value = [formatter stringFromNumber:[self.shape valueForKeyPath:attribute]];
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
    self.editingIndexPath = indexPath;
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    [self.tableView beginUpdates]; // This will cause an animated update of
    [self.tableView endUpdates];
    
    [UIView animateWithDuration:0.3 animations:^{
        for (AttributeTableViewCell *cell in self.tableView.visibleCells) {
            cell.descriptionTextLabel.alpha = 0;
        }
        cell.descriptionTextLabel.alpha = 1;
    }];
}


- (BOOL)attributeTableViewCellShouldBeginEditing:(AttributeTableViewCell *)cell
{
    return YES;
}

- (void)attributeTableViewCellDidChange:(AttributeTableViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *attribute = [self objectAtIndexPath:indexPath];
    
    [self.shape defineAttribute:attribute];
    [self.shape setStringValue:cell.textField.text forAttribute:attribute];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *attribute = [self objectAtIndexPath:indexPath];
    NSString *description = [self descriptionForAttribute:attribute];
    
    if ([indexPath isEqual:self.editingIndexPath] && description) {
        return 60;
    }
    return 44;
}

#pragma mark - Description

- (NSString *)descriptionForAttribute:(NSString *)attribute
{
    NSString *key = [NSString stringWithFormat:@"%@.%@.description", NSStringFromClass(self.shape.class), attribute];
    NSString *value = NSLocalizedString(key, @"");
    if ([[self.shape.class attributes] containsObject:attribute] && ![key isEqualToString:value]) {
        return value;
    }
    return nil;
}


@end
