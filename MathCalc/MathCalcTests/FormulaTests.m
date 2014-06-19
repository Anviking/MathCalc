//
//  FormulaTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//
//

#import <XCTest/XCTest.h>
#import "Formula.h"
#import "DDMathParser.h"

@interface FormulaTests : XCTestCase

@end

@implementation FormulaTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreation
{
    Formula *formula = [Formula formulaWithFormulaString:@"$area = $base+12*sin($circumference)"];
    NSArray *expectedVariables = @[@"base", @"circumference"];
    XCTAssertEqualObjects(formula.resultAttribute, @"area", @"");
    XCTAssertEqualObjects(formula.variableAttributes, expectedVariables, @"Objects are not equal: %@, %@", formula.variableAttributes, expectedVariables);
}

- (void)testABS {
    XCTAssertEqualObjects([@"abs(-2)" numberByEvaluatingString], @2, @"");
    XCTAssertEqualObjects([@"abs(2)" numberByEvaluatingString], @2, @"");
    XCTAssertNotEqualObjects([@"abs(-3)" numberByEvaluatingString], @2, @"");
}


@end
