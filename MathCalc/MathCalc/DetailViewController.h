//
//  DetailViewController.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Shape;

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) Shape *shape;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
