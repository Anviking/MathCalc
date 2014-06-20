//
//  AttributeTableViewCell.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-12.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VENCalculatorInputView.h"

@protocol AttributeTableViewCellDelegate;
@interface AttributeTableViewCell : UITableViewCell <UITextFieldDelegate, VENCalculatorInputViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *attributeLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UILabel *unitLabel;
@property (nonatomic, weak) IBOutlet id <AttributeTableViewCellDelegate> delegate;
@property (nonatomic) CGFloat definitionIndicatorWidth;
@property (nonatomic) BOOL defined;
@end

@protocol AttributeTableViewCellDelegate <NSObject>

- (void)attributeTableViewCellDidBeginEditing:(AttributeTableViewCell *)cell;
- (void)attributeTableViewCellDidChange:(AttributeTableViewCell *)cell;
- (BOOL)attributeTableViewCellShouldBeginEditing:(AttributeTableViewCell *)cell;

@end
