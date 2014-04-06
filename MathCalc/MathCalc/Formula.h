//
//  Formula.h
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Formula : NSObject

+ (Formula *)formulaWithFormulaString:(NSString *)string; // With format of "r = d * 2";
+ (NSArray *)formulasWithFormulasStrings:(NSArray *)array;

- (NSNumber *)evaluateWithVariables:(NSDictionary *)variables;

@property (nonatomic, strong) NSString *formulaString;
@property (nonatomic, strong) NSArray *variableKeys;
@property (nonatomic, strong) NSString *resultKey;
@end
