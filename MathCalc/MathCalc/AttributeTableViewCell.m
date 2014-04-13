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
@synthesize textLabel = __textLabel;

- (void)awakeFromNib
{
    // Initialization code
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
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
