//
//  Formula.h
//  MathCalc
//
//  Created by Johannes Lund on 2012-04-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Formula : NSObject

+ (Formula *)formulaWithFormulaString:(NSString *)string;
+ (NSArray *)formulasWithFormulasStrings:(NSArray *)array;

- (NSNumber *)evaluateWithVariables:(NSDictionary *)variables;

@property (nonatomic, strong) NSString *formulaString;
@property (nonatomic, strong) NSArray *variableAttributes;
@property (nonatomic, strong) NSString *resultAttribute;
@end
