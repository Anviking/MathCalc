//
//  SettingsViewController.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "SettingsViewController.h"

@import MathCore;

@implementation SettingsViewController {
    NSArray *array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    array = @[ [AngleFormatter class], [LengthFormatter class], [AreaFormatter class], [VolumeFormatter class] ];
    
    self.tableView.tintColor =  [AppDelegate tintColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, make sure we remove the current selection in our table view
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissModalViewControllerAnimated:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self objectAtSection:section] formatterUnits] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSString *unit = [self objectAtIndexPath:indexPath];
    UnitFormatter *defaultFormatter = [[self objectAtSection:indexPath.section] defaultFormatter];
    
    if ([defaultFormatter.unit isEqualToString:unit]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if ([unit isEqualToString:@""]) {
        unit = NSLocalizedString(@"None", @"");
    }
    
    cell.textLabel.text = unit;
    
    return cell;
}


- (id)objectAtSection:(NSInteger)section
{
    return array[section];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtSection:indexPath.section] formatterUnits][indexPath.row];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(NSStringFromClass([self objectAtSection:section]), @"");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = array[indexPath.section];
    
    NSString *unit = [class formatterUnits][indexPath.row];
    NSString *unitToDeselect = [[class defaultFormatter] unit];
    
    if (![unit isEqualToString:unitToDeselect]) {
        NSIndexPath *indexPathToDeselect = [NSIndexPath indexPathForRow:[[class formatterUnits] indexOfObject:unitToDeselect] inSection:indexPath.section];
        
        [class setDefaultFormatter:[class formatterWithUnit:unit]];
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath, indexPathToDeselect] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
