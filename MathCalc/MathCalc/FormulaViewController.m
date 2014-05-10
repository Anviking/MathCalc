//
//  FormulaViewController.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-02.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "FormulaViewController.h"

@implementation FormulaViewController {
    NSArray *_objects;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController)];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"mathTest" withExtension:@"html"];
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute : @(NSUTF8StringEncoding)};
    NSAttributedString *string = [[NSAttributedString alloc] initWithFileURL:url options:options documentAttributes:NULL error:nil];
    _objects = @[ string ];
}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    NSAttributedString *string = _objects[indexPath.row];
    cell.textLabel.attributedText = string;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


@end
