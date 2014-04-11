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


+ (NSArray *)attributes;

- (NSArray *)formulaStrings;

- (void)evaluateFormula:(Formula *)formula;

//Basic generic information about the shape
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *definedAttributes;
@property (nonatomic, strong) NSMutableArray *undefindedAttributes;
@property (nonatomic, strong) NSArray *formulas;

/// Delegate
@property (nonatomic, assign) id <ShapeDelegate> delegate;

- (NSDictionary *)substitutionDictionaryWithAttributes:(NSArray *)attributes;

@end

@protocol ShapeDelegate <NSObject>

- (void)shapeDidChange:(Shape *)shape;

@end
