//
//  RightTriangleTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RightTriangle.h"

@interface RightTriangleTests : XCTestCase
@property (nonatomic, strong) NSNumberFormatter *formatter;
@property (nonatomic, strong) NSDictionary *standardValues;
@end

@implementation RightTriangleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.formatter = [[NSNumberFormatter alloc] init];
    [self.formatter setMaximumFractionDigits:4];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    for (NSString *key in [[self standardTriangle] attributes]) {
        dictionary[key] = [[self standardTriangle] valueForKey:key] ?: @0;
    }
    
    self.standardValues = dictionary;
    
}

- (RightTriangle *)standardTriangle
{
    RightTriangle *triangle = [RightTriangle new];
    triangle.height = @4;
    triangle.area = @6;
    
    [triangle calculate];
    
    return triangle;
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCalculatingWithArea
{
    RightTriangle *triangle = [RightTriangle new];
    triangle.base = @3;
    triangle.height = @4;
    
    [triangle calculate];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.height], @"4", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.base], @"3", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.hypotenuse], @"5", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.area], @"6", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.circonference], @"12", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleA], @"53.1301", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleB], @"36.8699", @"");
    
    NSLog(@"Triangle: %@",triangle);
}

- (void)testCalculatingWithAreaAndHeight
{
    RightTriangle *triangle = [RightTriangle new];
    triangle.height = @4;
    triangle.area = @6;

    
    [triangle calculate];
    
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.height], @"4", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.base], @"3", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.hypotenuse], @"5", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.area], @"6", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.circonference], @"12", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleA], @"53.1301", @"");
    XCTAssertEqualObjects([self.formatter stringFromNumber:triangle.angleB], @"36.8699", @"");
    
    NSLog(@"Triangle: %@",triangle);
}



- (void)testAllCombinations
{
    NSMutableSet *set = [NSMutableSet set];
    RightTriangle *triangle = [self standardTriangle];
    NSArray *attributes = [triangle attributes];
    for (NSString *attribute1 in attributes) {
        for (NSString *attribute2 in attributes) {
            if (![attribute1 isEqualToString:attribute2]) {
                triangle = [RightTriangle new];
                [triangle setValue:[self standardValues][attribute1] forKey:attribute1];
                [triangle setValue:[self standardValues][attribute2] forKey:attribute2];
                
                [triangle calculate];
                
                if (![self validateTriangle:triangle]) {
                    [set addObject:[NSSet setWithArray:@[ attribute1, attribute2]]];
                }
            }
        }
    }
    
    [set minusSet:[self knownInvalidCombinations]];
    if (set.count != 0) {
         XCTFail(@"(%lu) invalid combinations:\n%@\n", (unsigned long)set.count, [self visualStringFromSet:set]);
    }
}

- (BOOL)validateTriangle:(RightTriangle *)triangle
{
    for (NSString *attribute in triangle.attributes) {
        NSString *calculatedValue = [self.formatter stringFromNumber:[triangle valueForKey:attribute]];
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
        [string appendFormat:@"%@ and %@ \n", array.firstObject, array.lastObject];
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

- (NSMutableSet *)knownInvalidCombinations
{
    NSArray *array = @[ @"angleA and angleB"];
    return [self setFomVisualStrings:array];
}

- (void)testFromulas
{
    RightTriangle *triangle = [RightTriangle new];
    triangle.base = @3;
    triangle.height = @4;
    
    [triangle calculate];
    
    for (Formula *formula in triangle.formulas) {
        NSString *attribute = formula.resultAttribute;
        NSNumber *value = [formula evaluateWithVariables:[triangle substitutionDictionaryWithAttributes:formula.variableAttributes]];
        NSString *newStringValue = [self.formatter stringFromNumber:value];
        NSString *oldStringValue = [self.formatter stringFromNumber:[triangle valueForKey:attribute]];
        XCTAssertEqualObjects(oldStringValue, newStringValue, @"\n    Formula: %@ = %@", formula.resultAttribute, formula.formulaString);
    }
}

@end
