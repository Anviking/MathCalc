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
        self.name = NSStringFromClass(self.class);
    }
    return self;
}

- (NSArray *)formulaStrings
{
    return nil;
}

- (NSArray *)formulas
{
    if (!_formulas) {
        _formulas = [Formula formulasWithFormulasStrings:[self formulaStrings]];
    }
    return _formulas;
}

+ (NSArray *)attributes
{
    return nil;
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
    self.definedAttributes = nil;
    NSMutableArray *formulas = [self formulas].mutableCopy;
    [self calculateWithFormulas:formulas];
    
}

- (void)calculateWithFormulas:(NSArray *)formulas
{
    NSMutableArray *array = formulas.mutableCopy;
    for (Formula *formula in formulas) {
        if (![self.definedAttributes containsObject:formula.resultAttribute]) {
            // It is a formula we should evaluate
            if (NSArrayContainsItemsFromArray(self.definedAttributes, formula.variableAttributes)) {
                // We can evaluate it.
                [self evaluateFormula:formula];
                [self.definedAttributes addObject:formula.resultAttribute];
                [array removeObject:formulas];
                
                // Start all over again
                [self calculateWithFormulas:array];
                break;
            }
            else {
                // We cannot evaluate the formula yet, maybe next time
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

- (NSMutableArray *)definedAttributes
{
    if (!_definedAttributes) {
        _definedAttributes = [NSMutableArray array];
        for (NSString *key in [self.class attributes]) {
            if ([self valueForKey:key]) {
                [_definedAttributes addObject:key];
            }
        }
    }
    return _definedAttributes;
}

- (NSMutableArray *)undefindedAttributes
{
    if (!_undefindedAttributes) {
        _undefindedAttributes = [NSMutableArray array];
        for (NSString *key in [self.class attributes]) {
            if (![self valueForKey:key]) {
                [_undefindedAttributes addObject:key];
            }
        }
    }
    return _undefindedAttributes;
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
    for (NSString *key in [self.class attributes]) {
        dictionary[key] = [self valueForKey:key] ?: @0;
    }
    return [dictionary description];
}

@end
