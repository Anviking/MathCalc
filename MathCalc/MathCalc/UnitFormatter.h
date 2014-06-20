//
//  UnitFormatter.h
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-20.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitFormatter : UITableViewController

+ (instancetype)formatterWithUnit:(NSString *)unit;
+ (NSArray *)formatterUnits;

+ (instancetype)defaultFormatter;
+ (void)setDefaultFormatter:(UnitFormatter *)formatter;

+ (NSDictionary *)formatterUnitFactors;

+ (NSString *)stringFromNumber:(NSNumber *)number;
+ (NSNumber *)numberFromString:(NSString *)string;

- (NSString *)stringFromNumber:(NSNumber *)number;
- (NSNumber *)numberFromString:(NSString *)string;

@property (nonatomic, copy) NSString *name; // E.g Kilograms
@property (nonatomic, copy) NSString *unit; // E.g kg

@end
