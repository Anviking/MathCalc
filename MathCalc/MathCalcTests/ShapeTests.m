//
//  ShapeTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-07.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "ShapeTests.h"

@implementation ShapeTests

- (Shape *)standardShape
{
    XCTFail(@"Override -standardShape");
    return nil;
}

- (Class)shapeClass
{
    XCTFail(@"Override -shapeClass");
    return Nil;
}

- (NSArray *)knownInvalidCombinations
{
    return nil;
}

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.formatter = [[NSNumberFormatter alloc] init];
    [self.formatter setMaximumFractionDigits:4];
    
    Shape *standardShape = [self standardShape];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *key in [self.shapeClass attributes]) {
        dictionary[key] = [standardShape valueForKey:key] ?: @0;
    }
    
    self.standardValues = dictionary;
}

- (void)validateCombinations
{
    NSMutableSet *set = [NSMutableSet set];
    Shape *shape = [[self shapeClass] new];
    NSArray *attributes = [self.shapeClass attributes];
    NSInteger dimensions = shape.minimumNumberOfAttributesRequired;
    
    if (dimensions == 1) {
        for (NSString *attribute1 in attributes) {
            shape = [[self shapeClass] new];
            [shape setValue:[self standardValues][attribute1] forKey:attribute1];
            
            [shape calculate];
            
            if (![self validateShape:shape]) {
                [set addObject:[NSSet setWithArray:@[ attribute1]]];
            }
        }
    } else if (dimensions == 2) {
        for (NSString *attribute1 in attributes) {
            for (NSString *attribute2 in attributes) {
                if (![attribute1 isEqualToString:attribute2]) {
                    shape = [[self shapeClass] new];
                    [shape setValue:[self standardValues][attribute1] forKey:attribute1];
                    [shape setValue:[self standardValues][attribute2] forKey:attribute2];
                    
                    [shape calculate];
                    
                    if (![self validateShape:shape]) {
                        [set addObject:[NSSet setWithArray:@[ attribute1, attribute2]]];
                    }
                }
            }
        }
    } else if (dimensions == 3) {
        for (NSString *attribute1 in attributes) {
            for (NSString *attribute2 in attributes) {
                for (NSString *attribute3 in attributes) {
                    if (![attribute1 isEqual:attribute2] && ![attribute1 isEqual:attribute3] && ![attribute2 isEqual:attribute3]) {
                        shape = [[self shapeClass] new];
                        [shape setValue:[self standardValues][attribute1] forKey:attribute1];
                        [shape setValue:[self standardValues][attribute2] forKey:attribute2];
                        [shape setValue:[self standardValues][attribute3] forKey:attribute3];
                        
                        [shape calculate];
                        
                        if (![self validateShape:shape]) {
                            [set addObject:[NSSet setWithArray:@[ attribute1, attribute2, attribute3]]];
                        }
                    }
                }
            }
        }
    }
    
    
    [set minusSet:[self setFomVisualStrings:[self knownInvalidCombinations]]];
    if (set.count != 0) {
        XCTFail(@"(%lu) invalid combinations:\n%@\n", (unsigned long)set.count, [self visualStringFromSet:set]);
    }
}

- (BOOL)validateShape:(Shape *)shape
{
    for (NSString *attribute in [shape.class attributes]) {
        NSString *calculatedValue = [self.formatter stringFromNumber:[shape valueForKey:attribute]];
        NSString *standardValue = [self.formatter stringFromNumber:self.standardValues[attribute]];
        
        if (![calculatedValue isEqualToString:standardValue]) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)visualStringFromSet:(NSSet *)set
{
    NSMutableString *string = @"".mutableCopy;
    for (NSSet *subSet in set) {
        NSArray *array = subSet.allObjects;
        [string appendString:@"\n    "];
        [string appendString:[array componentsJoinedByString:@" and "]];
    }
    return string;
}

- (NSMutableSet *)setFomVisualStrings:(NSArray *)array
{
    NSMutableSet *set = [NSMutableSet set];
    for (NSString *string in array) {
        NSSet *subset = [NSSet setWithArray:[string componentsSeparatedByString:@" and "]];
        [set addObject:subset];
    }
    return set;
}

- (void)validateFormulas
{
    Shape *shape = [self standardShape];
    
    for (Formula *formula in shape.formulas) {
        NSString *attribute = formula.resultAttribute;
        NSNumber *value = [formula evaluateWithVariables:[shape substitutionDictionaryWithAttributes:formula.variableAttributes]];
        NSString *newStringValue = [self.formatter stringFromNumber:value];
        NSString *oldStringValue = [self.formatter stringFromNumber:[shape valueForKey:attribute]];
        if (![newStringValue isEqualToString:oldStringValue]) {
            XCTFail(@"Invalid formula: %@   –  %@ should be %@ but it is %@", formula, attribute, oldStringValue, newStringValue);
        }
    }
}

@end
