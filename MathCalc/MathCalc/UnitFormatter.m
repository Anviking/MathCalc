//
//  UnitFormatter.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//


#import "UnitFormatter.h"
#import "NSNumber+JLAdditions.h"
#import "DDMathEvaluator.h"

@implementation UnitFormatter

#define JLAssertOverrideMethod [NSException raise:NSGenericException format:@"This method must be overridden"]; return nil

static NSMutableDictionary *formatters;

+ (void)initialize
{
    formatters = [NSMutableDictionary dictionary];
}

+ (void)setDefaultFormatter:(UnitFormatter *)formatter
{
    NSString *unit = formatter.unit;
    [[NSUserDefaults standardUserDefaults] setObject:unit forKey:NSStringFromClass(self.class)];
    [[NSUserDefaults standardUserDefaults] synchronize];
    formatters[NSStringFromClass(self)] = formatter;
}

+ (instancetype)defaultFormatter
{
    UnitFormatter *defaultFormatter = formatters[NSStringFromClass(self)];
    if (!defaultFormatter) {
        NSString *unit = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass(self.class)];
        if (!unit) {
            unit = [self formatterUnits].firstObject;
        }
        defaultFormatter = [self formatterWithUnit:unit];
        [self setDefaultFormatter:defaultFormatter];
    }
    return defaultFormatter;
}

+ (NSNumber *)numberFromString:(NSString *)string
{
    UnitFormatter *formatter = [self defaultFormatter];
    if (formatter) {
         return [[self defaultFormatter] numberFromString:string];
    }
    
    NSLocale *locale = [NSLocale currentLocale];
    NSString *decimalSymbol = [locale objectForKey:NSLocaleDecimalSeparator];
    string = [string stringByReplacingOccurrencesOfString:decimalSymbol withString:@"."];
    NSNumber *number = [[DDMathEvaluator sharedMathEvaluator] evaluateString:string withSubstitutions:nil];
    
    return number;
}

+ (NSString *)stringFromNumber:(NSNumber *)number
{
    UnitFormatter *formatter = [self defaultFormatter];
    if (formatter) {
        return [[self defaultFormatter] stringFromNumber:number];
    }
    return [number string];
}

+ (NSArray *)formatterUnits
{
    JLAssertOverrideMethod;
}

+ (NSDictionary *)formatterUnitFactors
{
    JLAssertOverrideMethod;
}

+ (instancetype)formatterWithUnit:(NSString *)unit
{
    UnitFormatter *formatter = [self new];
    formatter.unit = unit;
    return formatter;
}

- (NSString *)stringFromNumber:(NSNumber *)number
{
    if (!number) {
        return nil;
    }
    for (NSString *unit in [[self class] formatterUnits]) {
        if ([self.unit isEqualToString:unit]) {
            NSNumber *factor = [[self class] formatterUnitFactors][unit];
            NSParameterAssert(factor);
            number = @(number.doubleValue * factor.doubleValue);
            break;
        }
    }
    return [number string];
}


- (NSNumber *)numberFromString:(NSString *)string
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *decimalSymbol = [locale objectForKey:NSLocaleDecimalSeparator];
    string = [string stringByReplacingOccurrencesOfString:decimalSymbol withString:@"."];
    NSNumber *number = [[DDMathEvaluator sharedMathEvaluator] evaluateString:string withSubstitutions:nil];
    
    for (NSString *unit in [[self class] formatterUnits]) {
        if ([self.unit isEqualToString:unit]) {
            NSNumber *factor = [[self class] formatterUnitFactors][unit];
            NSParameterAssert(factor);
            number = @(number.doubleValue / factor.doubleValue);
            break;
        }
    }
    return number;
}

@end
