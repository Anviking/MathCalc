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

- (BOOL)hasValueForAttribute:(NSString *)attribute;
- (BOOL)hasValueForAttributes:(NSArray *)attributes;
- (void)defineAttribute:(NSString *)attribute;
- (void)undefineAttribute:(NSString *)attribute;

@property (nonatomic, strong) NSMutableArray *definedAttributes;
@property (nonatomic, strong) NSMutableArray *calculatedAttributes;
@property (nonatomic, strong) NSMutableArray *undefinedAttributes;

//Basic generic information about the shape
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *formulas;

/// Delegate
@property (nonatomic, assign) id <ShapeDelegate> delegate;

- (NSDictionary *)substitutionDictionaryWithAttributes:(NSArray *)attributes;

@end

@protocol ShapeDelegate <NSObject>
@optional

- (void)shapeWillCalculate:(Shape *)shape;
- (void)shapeDidCalculate:(Shape *)shape;

- (void)shape:(Shape *)shape willDefineAttribute:(NSString *)attribute;
- (void)shape:(Shape *)shape willUndefineAttribute:(NSString *)attribute;
- (void)shape:(Shape *)shape didDefineAttribute:(NSString *)attribute;
- (void)shape:(Shape *)shape didUndefineAttribute:(NSString *)attribute;
- (void)shape:(Shape *)shape didCalculateValue:(NSNumber *)number attribute:(NSString *)attribute;
- (void)shape:(Shape *)shape willCalculateValue:(NSNumber *)number attribute:(NSString *)attribute;

@end
