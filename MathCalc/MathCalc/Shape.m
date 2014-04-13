//
//  Shape.m
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shape.h"
#import "JLDelegateProxy.h"

@implementation Shape {
    id <ShapeDelegate> delegateProxy;
}

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

- (void)setDelegate:(id<ShapeDelegate>)delegate
{
    _delegate = delegate;
    delegateProxy = (id <ShapeDelegate>)[[JLDelegateProxy alloc] initWithDelegate:delegate];
}

- (void)reset
{
    self.definedAttributes = nil;
    self.undefinedAttributes = nil;
    
    for (NSString *attribute in [self.class attributes]) {
        [self setValue:nil forKey:attribute];
    }
}

#pragma mark - Calculate

- (void)calculate
{
    [delegateProxy shapeWillCalculate:self];
    NSMutableArray *formulas = [self formulas].mutableCopy;
    
    for (NSString *attribute in self.undefinedAttributes) {
        [self setValue:nil forKey:attribute];
    }
    
    [self calculateWithFormulas:formulas];
    [delegateProxy shapeDidCalculate:self];
}

- (void)calculateWithFormulas:(NSArray *)formulas
{
    NSMutableArray *array = formulas.mutableCopy;
    for (Formula *formula in formulas) {
        if (![self hasValueForAttribute:formula.resultAttribute]) {
            // It is a formula we should evaluate
            if ([self hasValueForAttributes:formula.variableAttributes]) {
                // We can evaluate it.
                [self evaluateFormula:formula];
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

- (void)calculateAttributes
{
    [self.formulas enumerateObjectsUsingBlock:^(Formula *formula, NSUInteger idx, BOOL *stop) {
        [self evaluateFormula:formula];
    }];
}

#pragma mark - Helpers

- (BOOL)hasValueForAttribute:(NSString *)attribute
{
    NSNumber *number = [self valueForKey:attribute];
    if (number && number.floatValue > 0.0) {
        return YES;
    }
    return NO;
}

- (BOOL)hasValueForAttributes:(NSArray *)attributes
{
    for (NSString *string in attributes) {
        if (![self hasValueForAttribute:string]) {
            return NO;
        }
    }
    return YES;
}

- (void)defineAttribute:(NSString *)attribute
{
    if ([self.definedAttributes containsObject:attribute]) {
        return;
    }
    
    [delegateProxy shape:self willDefineAttribute:attribute];
    NSMutableArray *invalidAttributes = [self invalidAttributes];
    if (invalidAttributes.count > 0) {
        [self moveAttribute:attribute toArray:self.definedAttributes];
    }
    else if (invalidAttributes.count == 0) {
        [self undefineAttribute:self.definedAttributes.lastObject];
        [self moveAttribute:attribute toArray:self.definedAttributes];
    }
    [delegateProxy shape:self didDefineAttribute:attribute];
}

- (void)undefineAttribute:(NSString *)attribute
{
    [delegateProxy shape:self willUndefineAttribute:attribute];
    [self moveAttribute:attribute toArray:self.undefinedAttributes];
    [delegateProxy shape:self didUndefineAttribute:attribute];
}

- (void)moveAttribute:(NSString *)attribute toArray:(NSMutableArray *)array
{
    [self.definedAttributes removeObject:attribute];
    [self.undefinedAttributes removeObject:attribute];
    [array addObject:attribute];
}

- (NSMutableArray *)definedAttributes
{
    if (!_definedAttributes) {
        _definedAttributes = [NSMutableArray array];
    }
    return _definedAttributes;
}


- (NSMutableArray *)undefinedAttributes
{
    if (!_undefinedAttributes) {
        _undefinedAttributes = [self.class attributes].mutableCopy;
    }
    return _undefinedAttributes;
}

- (NSMutableArray *)invalidAttributes
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSString *attribute in self.class.attributes) {
        if (![self valueForKey:attribute]) {
            [array addObject:attribute];
        }
    }
    return array;
}

- (void)evaluateFormula:(Formula *)formula
{
    NSString *attribute = formula.resultAttribute;
    NSNumber *value = [formula evaluateWithVariables:[self substitutionDictionaryWithAttributes:formula.variableAttributes]];
    [delegateProxy shape:self willCalculateValue:value attribute:attribute];
    [self setValue:value forKey:attribute];
    [delegateProxy shape:self didCalculateValue:value attribute:attribute];
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
