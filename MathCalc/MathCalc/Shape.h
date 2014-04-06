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

- (NSArray *)formulaStrings;

- (void)evaluateFormula:(Formula *)formula;

//Basic generic information about the shape
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *attributes;
@property (nonatomic, strong) NSMutableArray *validAttributes;
@property (nonatomic, strong) NSArray *formulas;

/// Like "r", "h" and @"A"
@property (nonatomic, strong) NSDictionary *attributeVariables;

/// Delegate
@property (nonatomic, assign) id <ShapeDelegate> delegate;

- (NSDictionary *)substitutionDictionaryWithAttributes:(NSArray *)attributes;

- (NSString *)variableNameFromAttribute:(NSString *)attribute;
- (NSString *)attributeFromVariableName:(NSString *)attribute;

@end

@protocol ShapeDelegate <NSObject>

- (void)shapeDidChange:(Shape *)shape;

@end
