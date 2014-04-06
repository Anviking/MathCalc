//
//  Shape.m
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shape.h"

@implementation Shape

- (id)init
{
    self = [super init];
    if (self) {
        self.formulas = [Formula formulasWithFormulasStrings:[self formulaStrings]];
    }
    return self;
}

- (NSArray *)primitiveFormulaStings
{
    return nil;
}

- (NSArray *)formulaStrings
{
    return nil;
}

- (NSArray *)attributes
{
    return [[self attributeVariables] allKeys];
}


- (NSString *)attributeFromVariableName:(NSString *)variable
{
    NSArray *keys = [self.attributeVariables allKeysForObject:variable];
    NSAssert(keys.count == 1, @"Multiple attributes associated with the same variable");
    return keys.firstObject;
}

- (NSString *)variableNameFromAttribute:(NSString *)attribute
{
    return self.attributeVariables[attribute];
}

- (NSDictionary *)substitutionDictionaryWithAttributes:(NSArray *)attributes
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *attribute in attributes) {;
        NSNumber *number = [self valueForKey:attribute] ?: @0;
        dictionary[attribute] = number;
    }
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

#pragma mark - Calculate

- (void)calculate
{
    self.validAttributes = nil;
    NSMutableArray *formulas = [self formulas].mutableCopy;
    [self calculateWithFormulas:formulas];
    
}

- (void)calculateWithFormulas:(NSArray *)formulas
{
    NSMutableArray *array = formulas.mutableCopy;
    for (Formula *formula in formulas) {
        if (![self.validAttributes containsObject:formula.resultAttribute]) {
            // It is a formula we should evaluate
            if (NSArrayContainsItemsFromArray(self.validAttributes, formula.variableAttributes)) {
                // We can evaluate it.
                [self evaluateFormula:formula];
                [self.validAttributes addObject:formula.resultAttribute];
                [array removeObject:formulas];
                
                NSLog(@"Calculated :%@", formula.resultAttribute);
                
                // Start all over again
                [self calculateWithFormulas:array];
                break;
            }
            else {
                // We cannot evaluate the formula yet, maybe next time
                NSLog(@"Cannot calculate: %@", formula.resultAttribute);
            }
        }
        else {
            // We already have the result of this formula
            [array removeObject:formula];
        }
    }
}


extern BOOL NSArrayContainsItemsFromArray(NSArray *array1, NSArray *array2)
{
    for (id obj in array2) {
        if (![array1 containsObject:obj]) {
            return NO;
        }
    }
    return YES;
}

- (void)calculateAttributes
{
    [self.formulas enumerateObjectsUsingBlock:^(Formula *formula, NSUInteger idx, BOOL *stop) {
        [self evaluateFormula:formula];
    }];
}

#pragma mark - Helpers

- (NSMutableArray *)validAttributes
{
    if (!_validAttributes) {
        _validAttributes = [NSMutableArray array];
        for (NSString *key in [self attributes]) {
            if ([self valueForKey:key]) {
                [_validAttributes addObject:key];
            }
        }
    }
    return _validAttributes;
}

- (void)evaluateFormula:(Formula *)formula
{
    NSString *attribute = formula.resultAttribute;
    NSNumber *value = [formula evaluateWithVariables:[self substitutionDictionaryWithAttributes:formula.variableAttributes]];
    [self setValue:value forKey:attribute];
}

- (NSString *)description
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *key in [self attributes]) {
        dictionary[key] = [self valueForKey:key] ?: @0;
    }
    return [dictionary description];
}

@end
