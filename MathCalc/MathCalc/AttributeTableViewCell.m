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

static VENCalculatorInputView *inputView;
+ (void)initialize {
    inputView = [VENCalculatorInputView new];
}

- (void)awakeFromNib
{
    // Initialization code
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.inputView = inputView;
    
    self.definitionIndicatorWidth = 5;
    
    self.colorView.backgroundColor = [AppDelegate tintColor];
    
    [self prepareForReuse];
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
    self.unitLabel.text = nil;
    self.descriptionTextLabel.text = nil;
    self.colorView.hidden = YES;
    self.colorViewWidthConstraint.constant = -10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.colorView.backgroundColor = [AppDelegate tintColor];
}

- (void)setDefined:(BOOL)defined
{
    if (defined != _defined) {
        CGFloat endX;
        
        if (defined) {
            endX = -10 + self.definitionIndicatorWidth;
        } else {
            endX = -10;
        }
        
        
        self.colorView.hidden = NO;
        [self.contentView layoutIfNeeded];
        self.colorViewWidthConstraint.constant = endX;

        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:0 animations:^{
            [self.contentView layoutIfNeeded];
        } completion:nil];
    }
    _defined = defined;
}

#pragma mark - 

- (void)calculatorInputView:(VENCalculatorInputView *)inputView didTapKey:(NSString *)key {
    NSLog(@"Just tapped key: %@", key);
    
    [self.textField insertText:key];
    // Handle the input. Something like [myTextField insertText:key];
}

- (void)calculatorInputViewDidTapBackspace:(VENCalculatorInputView *)calculatorInputView {
    NSLog(@"Just tapped backspace.");
    [self.textField deleteBackward];
    // Handle the backspace. Something like [myTextField deleteBackward];
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // inputView is static
    inputView.delegate = self;
    [delegateProxy attributeTableViewCellDidBeginEditing:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    inputView.delegate = nil;
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
