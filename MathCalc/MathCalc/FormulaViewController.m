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

- (void)loadView
{
    self.webView = [[UIWebView alloc] init];
    self.view = self.webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissViewController)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"mathTest" withExtension:@"html"];
        NSString *format = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        
        NSAssert(!error, @"Error loading format string from disk");
        
        self.body = @"When $a \\ne 0$, there are two solutions to \\(ax^2 + bx + c = 0\\)";
        
        NSString *pathToMathJax = [[NSBundle mainBundle] pathForResource:@"MathJax" ofType:@"js"];
        pathToMathJax = @"MathJax.js";
        
        NSString *string = [NSString stringWithFormat:format, pathToMathJax, self.body];
        [self.webView loadHTMLString:string baseURL:[[NSBundle mainBundle] bundleURL]];
    });

}

- (void)dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
