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
}

- (void)setDelegate:(id<AttributeTableViewCellDelegate>)delegate
{
    _delegate = delegate;
    delegateProxy = (id <AttributeTableViewCellDelegate>)[[JLDelegateProxy alloc] initWithDelegate:delegate];
}

- (void)prepareForReuse
{
    self.userInteractionEnabled = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
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
