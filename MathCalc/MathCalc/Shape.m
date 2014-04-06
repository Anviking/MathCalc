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
    
}

- (void)calculateVariable:(NSString *)string
{
    
}

- (void)calculatePrimitiveAttributes
{
    NSMutableSet *missingPrimitiveAttributes = [self missingPrimitiveAttributes];
    NSMutableSet *validAttributes = [self validAttributes];
    for (NSString *attribute in missingPrimitiveAttributes) {
        NSLog(@"Looking to calculate: %@", attribute);
        for (Formula *formula in self.primitiveFormulas) {
            if (NSSetContainsItemsFromNSArray(validAttributes, formula.variableAttributes) && [formula.resultAttribute isEqualToString:attribute]) {
                [self evaluateFormula:formula];
                [validAttributes addObject:formula.resultAttribute];
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

- (NSMutableSet *)validAttributes
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSString *key in [self attributes]) {
        if ([self valueForKey:key]) {
            [set addObject:key];
        }
    }
    return set;
}

- (NSMutableSet *)missingAttributes
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSString *key in [self attributes]) {
        if (![self valueForKey:key]) {
            [set addObject:key];
        }
    }
    return set;
}

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
    NSString *attribute = [self attributeFromVariableName:formula.resultAttribute];
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
