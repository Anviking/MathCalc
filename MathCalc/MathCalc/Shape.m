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
        self.primitiveFormulas = [Formula formulasWithFormulasStrings:[self primitiveFormulaStings]];
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

- (NSDictionary *)substitutionDictionaryWithVariables:(NSArray *)variables
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *variable in variables) {
        NSString *attribute = [self attributeFromVariableName:variable];
        NSNumber *number = [self valueForKey:attribute] ?: @0;
        dictionary[variable] = number;
    }
    return [NSDictionary dictionaryWithDictionary:dictionary];
}

- (NSMutableSet *)validVariables
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSString *key in self.attributes) {
        NSNumber *number = [self valueForKey:key];
        if (number.floatValue) {
            [set addObject:[self variableNameFromAttribute:key]];
        }
    }
    return set;
}

#pragma mark - Calculate

- (void)calculate
{
    if ([self missingPrimitiveAttributes].count > 0) {
        [self calculatePrimitiveAttributes];
    }
    [self calculateAttributes];
}

- (void)calculatePrimitiveAttributes
{
    NSMutableSet *missingPrimitiveAttributes = [self missingPrimitiveAttributes];
    NSMutableSet *validVariables = [self validVariables];
    for (NSString *attribute in missingPrimitiveAttributes) {
        NSLog(@"Looking to calculate: %@", attribute);
        for (Formula *formula in self.primitiveFormulas) {
            if (NSSetContainsItemsFromNSArray(validVariables, formula.variableKeys) && [formula.resultKey isEqualToString:[self variableNameFromAttribute:attribute]]) {
                [self evaluateFormula:formula];
                [validVariables addObject:formula.resultKey];
            }
        }
    }
}

extern BOOL NSSetContainsItemsFromNSArray(NSSet *set, NSArray *array)
{
    for (id obj in array) {
        if (![set containsObject:obj]) {
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

- (NSMutableSet *)validPrimitiveAttributes
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSString *key in [self primitiveAttributes]) {
        if ([self valueForKey:key]) {
            [set addObject:key];
        }
    }
    return set;
}

- (NSMutableSet *)missingPrimitiveAttributes
{
    NSMutableSet *set = [NSMutableSet setWithArray:[self primitiveAttributes]];
    [set minusSet:[self validPrimitiveAttributes]];
    return set;
}

- (void)evaluateFormula:(Formula *)formula
{
    NSString *attribute = [self attributeFromVariableName:formula.resultKey];
    NSNumber *value = [formula evaluateWithVariables:[self substitutionDictionaryWithVariables:formula.variableKeys]];
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
