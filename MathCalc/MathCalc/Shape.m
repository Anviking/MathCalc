//
//  Shape.m
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shape.h"
#import "JLDelegateProxy.h"
#import "DDMathEvaluator.h"

@implementation Shape {
    id <ShapeDelegate> delegateProxy;
}

+ (instancetype)defaultShape
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:NSStringFromClass(self)];
    Shape *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    if (!object) {
        object = [self new];
    }
    return object;
}

- (void)save
{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:NSStringFromClass(self.class)];
    [defaults synchronize];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.name = NSStringFromClass(self.class);
        self.formulas = [Formula formulasWithFormulasStrings:[self formulaStrings]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        for (NSString *attribute in [[self class] attributes]) {
            [self setValue:[decoder decodeObjectForKey:attribute] forKey:attribute];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    for (NSString *attribute in [[self class] attributes]) {
        [encoder encodeObject:[self valueForKey:attribute] forKey:attribute];
    }
}



- (NSArray *)formulaStrings
{
    return nil;
}

+ (NSArray *)attributes
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSArray *array in [self groupedAttributes]) {
        [result addObjectsFromArray:array];
    }
    return result;
}

+ (NSArray *)groupedAttributes
{
    return @[ [self attributes] ];
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
    
    [self save];
}

#pragma mark - Calculate

- (void)calculate
{
    [delegateProxy shapeWillCalculate:self];
    NSMutableArray *formulas = [self formulas].mutableCopy;
    
    [self defineAttributesIfNeeded];
    for (NSString *attribute in self.undefinedAttributes) {
        [self setValue:nil forKey:attribute];
    }
    
    [self calculateWithFormulas:formulas iteration:0];
    [delegateProxy shapeDidCalculate:self];
}

- (void)defineAttributesIfNeeded
{
    if (!self.definedAttributes.count) {
        for (NSString *attribute in [self.class attributes]) {
            if ([[self valueForKey:attribute] floatValue] > 0) {
                [self defineAttribute:attribute];
            }
        }
    }
}

- (void)calculateWithFormulas:(NSArray *)formulas iteration:(NSInteger)iteration
{
    if (iteration > self.formulas.count) {
        return;
    }
    
    NSMutableArray *array = formulas.mutableCopy;
    for (Formula *formula in formulas) {
        if (![self hasValueForAttribute:formula.resultAttribute] && ![self.definedAttributes containsObject:formula.resultAttribute]) {
            // It is a formula we should evaluate
            if ([self hasValueForAttributes:formula.variableAttributes]) {
                // We can evaluate it.
                [self evaluateFormula:formula];
                [array removeObject:formulas];
                
                // Start all over again
                [self calculateWithFormulas:array iteration:iteration + 1];
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

- (Class)formatterClassForAttribute:(NSString *)attribute
{
    if ([[[self class] attributes] containsObject:attribute]) {
        attribute = attribute.lowercaseString;
        if ([attribute containsString:@"angle"]){
            return [AngleFormatter class];
        } else if ([attribute containsString:@"area"]){
            return [AreaFormatter class];
        } else if ([attribute isEqualToString:@"volume"]) {
            return [VolumeFormatter class];
        } else {
            return [LengthFormatter class];
        }
    }
    return Nil;
}


- (void)setStringValue:(NSString *)string forAttribute:(NSString *)attribute
{
    NSNumber *number = [[self formatterClassForAttribute:attribute] numberFromString:string];
    [self setValue:number forKey:attribute];
}

- (BOOL)hasValueForAttribute:(NSString *)attribute
{
    NSNumber *number = [self valueForKey:attribute];
    return (BOOL)number && number.doubleValue > 0;
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
    if (!attribute) return;

    if ([self.definedAttributes containsObject:attribute]) {
        return;
    }
    
    [delegateProxy shape:self willDefineAttribute:attribute];
    
    NSMutableArray *attributesToUndefine = [NSMutableArray array];
    // Defined attributes that should not be concidered defined
    // Delegate call for didUndefineAttribute will not be called until -willDefineAttribute has been
    
    for (NSString *attribute in self.definedAttributes) {
        if ([self valueForKey:attribute] == nil) {
            [attributesToUndefine addObject:attribute];
            [delegateProxy shape:self willUndefineAttribute:attribute];
        }
    }
    
    // Complete the undefinition of the invalidly defined attributes
    for (NSString *attribute in attributesToUndefine) {
        [self moveAttribute:attribute toArray:self.undefinedAttributes];
        [delegateProxy shape:self didUndefineAttribute:attribute];
    }
    
    if (self.definedAttributes.count == self.minimumNumberOfAttributesRequired) {
        NSString *attribute = self.definedAttributes.lastObject;
        [delegateProxy shape:self willUndefineAttribute:attribute];
        [self moveAttribute:attribute toArray:self.undefinedAttributes];
        [delegateProxy shape:self didUndefineAttribute:attribute];
    }
    
    [self moveAttribute:attribute toArray:self.definedAttributes];
    [delegateProxy shape:self didDefineAttribute:attribute];
}

- (void)undefineAttribute:(NSString *)attribute
{
    if (!attribute) return;
    
    if ([self.undefinedAttributes containsObject:attribute]) {
        return;
    }
    
    [delegateProxy shape:self willUndefineAttribute:attribute];
    [self moveAttribute:attribute toArray:self.undefinedAttributes];
    [delegateProxy shape:self didUndefineAttribute:attribute];
}

- (void)moveAttribute:(NSString *)attribute toArray:(NSMutableArray *)array
{
    if (!attribute) return;

    [self.definedAttributes removeObject:attribute];
    [self.undefinedAttributes removeObject:attribute];
    
    if (array == self.definedAttributes) {
        [array addObject:attribute];
    } else {
        [array insertObject:attribute atIndex:0];
    }
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
    if (!isfinite([value doubleValue])) {
        return;
    }
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
