//
//  Formula.m
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Formula.h"
#import "DDMathEvaluator.h"
#import "DDExpression.h"

@implementation Formula

+ (void)initialize
{
    [[DDMathEvaluator sharedMathEvaluator] setAngleMeasurementMode:DDAngleMeasurementModeDegrees];
    
    DDMathFunction function = ^ DDExpression* (NSArray *args, NSDictionary *variables, DDMathEvaluator *evaluator, NSError **error) {
        if ([args count] != 1) {
            //fill in *error and return nil
        }
        NSNumber *n = [[DDMathEvaluator sharedMathEvaluator] evaluateString:args[0] withSubstitutions:variables];
        NSNumber *result = [NSNumber numberWithDouble:ABS([n doubleValue])];
        return [DDExpression numberExpressionWithNumber:result];
    };
    
    [[DDMathEvaluator sharedMathEvaluator] registerFunction:function forName:@"abs"];

}

+ (NSArray *)formulasWithFormulasStrings:(NSArray *)array
{
    NSMutableArray *mutableArray = @[].mutableCopy;
    for (NSString *string in array) {
        [mutableArray addObject:[Formula formulaWithFormulaString:string]];
    }
    return [NSArray arrayWithArray:mutableArray];
}

+ (Formula *)formulaWithFormulaString:(NSString *)rawString
{
    Formula *formula = [Formula new];
    formula.resultAttribute = [self resultKeyFromRawString:rawString];
    formula.formulaString  = [self formulaStringFromRawString:rawString];
    formula.variableAttributes = [self variablesFromFormula:formula.formulaString];
    
    return formula;
}

- (NSNumber *)evaluateWithVariables:(NSDictionary *)variables
{
    return [[DDMathEvaluator sharedMathEvaluator] evaluateString:self.formulaString withSubstitutions:variables];
}

+ (NSString *)resultKeyFromRawString:(NSString *)string
{
    return [[string componentsSeparatedByString:@"="].firstObject stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" $"]];
}

+ (NSString *)formulaStringFromRawString:(NSString *)string
{
    return [[string componentsSeparatedByString:@"="].lastObject stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
}

+ (NSArray *)variablesFromFormula:(NSString *)string
{
    __block NSMutableArray *variables = @[].mutableCopy;
    static NSRegularExpression *expression;
    if (!expression) {
        expression = [NSRegularExpression regularExpressionWithPattern:@"(?<=\\$)[A-Za-z]+" options:0 error:nil];
    }
    
    [expression enumerateMatchesInString:string options:0 range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        [variables addObject:[string substringWithRange:result.range]];
    }];
    return variables.copy;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ = %@", self.resultAttribute, self.formulaString];
}


@end
