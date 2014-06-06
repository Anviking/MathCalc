//
//  AttributeTableViewCell.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-12.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "AttributeTableViewCell.h"
#import "JLDelegateProxy.h"

@implementation AttributeTableViewCell {
    id <AttributeTableViewCellDelegate> delegateProxy;
    CALayer *layer;
}

- (void)awakeFromNib
{
    // Initialization code
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    
    self.textField.textColor = [UIColor whiteColor];
    self.attributeLabel.textColor = [UIColor whiteColor];
    self.attributeLabel.highlightedTextColor = [UIColor whiteColor];
    
    self.definitionIndicatorWidth = 5;
    
    layer = [CALayer layer];
    layer.backgroundColor = self.tintColor.CGColor;
    layer.hidden = YES;
    
    [self.contentView.layer addSublayer:layer];
}

- (void)setDelegate:(id<AttributeTableViewCellDelegate>)delegate
{
    _delegate = delegate;
    delegateProxy = (id <AttributeTableViewCellDelegate>)[[JLDelegateProxy alloc] initWithDelegate:delegate];
}


- (void)prepareForReuse
{
    self.userInteractionEnabled = YES;
    self.defined = NO;
}

- (void)setDefined:(BOOL)defined
{
    if (defined != _defined) {
        CGFloat startX, endX;
        
        if (defined) {
            startX = -self.definitionIndicatorWidth;
            endX = 0;
        } else {
            startX = 0;
            endX = -self.definitionIndicatorWidth;
        }
        
        
        layer.hidden = NO;
        layer.frame = CGRectMake(startX, 0, self.definitionIndicatorWidth, self.bounds.size.height);
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.01 initialSpringVelocity:1 options:0 animations:^{
            layer.frame = CGRectMake(endX, 0, self.definitionIndicatorWidth, self.bounds.size.height);
        } completion:nil];
    }
    _defined = defined;
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [delegateProxy attributeTableViewCellDidBeginEditing:self];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    [delegateProxy attributeTableViewCellDidChange:self];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return [delegateProxy attributeTableViewCellShouldBeginEditing:self];
}

@end
