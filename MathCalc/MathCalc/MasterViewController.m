//
//  MasterViewController.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "FormulaViewController.h"
#import "MathCore.h"

@interface MasterViewController () {
    NSArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _objects = @[ [Circle new], [RightTriangle new], [Sphere new], [Pyramid new], [Cone new], [Cuboid new] ].mutableCopy;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Shape *object = _objects[indexPath.row];
    cell.textLabel.text = [object name];
//    cell.imageView.image = [UIImage imageNamed:object.name.lowercaseString];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Shape *shape = _objects[indexPath.row];
        [[segue destinationViewController] setShape:shape];
    } else {
        NSMutableString *body = [NSMutableString new];
        Pyramid *pyramid = [Pyramid new];
        for (NSString *string in pyramid.formulaStrings) {
            [body appendFormat:@"<p style=\"text-align:center\">\n`%@`\n</p>",[string stringByReplacingOccurrencesOfString:@"$" withString:@""]];
        }
            [body appendFormat:@"<p style=\"text-align:center\">`%@`</p>",@"x = sqrt(y+z)"];
        [(FormulaViewController *)[[segue destinationViewController] viewControllers][0] setBody:body];
        
    }
}

@end
