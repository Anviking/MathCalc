//
//  FormulaViewController.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-02.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormulaViewController : UIViewController

@property (nonatomic, strong) NSString *body;

@property (nonatomic, strong) IBOutlet UIWebView *webView;

@end
