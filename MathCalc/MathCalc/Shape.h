//
//  Shape.h
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Formula.h"

@protocol ShapeDelegate;
@interface Shape : NSObject

- (void)calculate;
- (void)calculateAttributes;

- (NSArray *)primitiveFormulaStings;
- (NSArray *)formulaStrings;

- (void)evaluateFormula:(Formula *)formula;

//Basic generic information about the shape
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *attributes;
@property (nonatomic, strong) NSDictionary *attributeVariables;

/// Primitive attributes for the shape
@property (nonatomic, strong) NSArray *primitiveAttributes;

/// Formulas for calculating primitive attributes
@property (nonatomic, strong) NSArray *primitiveFormulas;

/// Other formulas
@property (nonatomic, strong) NSArray *formulas;

/// The attributes used for the calculation
@property (nonatomic, strong) NSArray *providingAttributes;

/// Delegate
@property (nonatomic, assign) id <ShapeDelegate> delegate;

- (NSString *)variableNameFromAttribute:(NSString *)attribute;
- (NSString *)attributeFromVariableName:(NSString *)attribute;

@end

@protocol ShapeDelegate <NSObject>

- (void)shapeDidChange:(Shape *)shape;

@end
