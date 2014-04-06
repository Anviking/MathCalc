//
//  FormulaTests.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-04-06.
//
//

#import <XCTest/XCTest.h>
#import "Formula.h"

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
    Formula *formula = [Formula formulaWithFormulaString:@"$a = $b+12*sin($c)"];
    NSArray *expectedVariables = @[@"b", @"c"];
    XCTAssertEqualObjects(formula.resultKey, @"a", @"");
    XCTAssertEqualObjects(formula.variableKeys, expectedVariables, @"Objects are not equal: %@, %@", formula.variableKeys, expectedVariables);
}


@end
