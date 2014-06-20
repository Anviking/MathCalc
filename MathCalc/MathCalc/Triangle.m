//
//  Triangle.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-06-19.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Triangle.h"

@implementation Triangle

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Triangle";
    }
    return self;
}

+ (NSArray *)groupedAttributes
{
    return @[ @[ @"sideA", @"sideB", @"sideC" ],
              @[ @"angleA", @"angleB", @"angleC" ],
              @[ @"area", @"perimeter"]];
}

- (NSDictionary *)formulaSubstitutions {
    return @{ @"a" : @"$sideA",
              @"b" : @"$sideB",
              @"c" : @"$sideC",
              @"A" : @"$angleA",
              @"B" : @"$angleB",
              @"C" : @"$angleC",
              @"P" : @"$perimeter",
              @"S" : @"$area" };
}

- (NSArray *)formulaStrings
{
    return @[ @"$perimeter = $sideA + $sideB + $sideC",
              @"$sideA = $perimeter - $sideB - $sideC",
              @"$sideB = $perimeter - $sideA - $sideC",
              @"$sideC = $perimeter - $sideA - $sideB",
              
              @"$angleA = 180 - $angleB - $angleC",
              @"$angleB = 180 - $angleA - $angleC",
              @"$angleC = 180 - $angleB - $angleA",
              
              @"$area = $sideB*$sideC*sin($angleA)/2",
              @"$area = $sideA*$sideB*sin($angleC)/2",
              @"$area = $sideC*$sideA*sin($angleB)/2",
              
              @"$sideA = $sideC sin($angleA) csc($angleC)",
              @"$sideB = $sideC sin($angleB) csc($angleC)",
              @"$sideC = $sideA sin($angleC) csc($angleA)",
              
              
              @"$angleA = acos((-pow($sideA,2)+pow($sideB,2)+pow($sideC,2))/(2 $sideB $sideC))",
              @"$angleB = acos((-pow($sideB,2)+pow($sideC,2)+pow($sideA,2))/(2 $sideC $sideA))",
              @"$angleC = acos((-pow($sideC,2)+pow($sideA,2)+pow($sideB,2))/(2 $sideA $sideB))",
              
              // SAS
              @"$sideA = sqrt(pow($sideB,2)+pow($sideC,2)-2*$sideB*$sideC*cos($angleA))",
              @"$sideB = sqrt(pow($sideC,2)+pow($sideA,2)-2*$sideC*$sideA*cos($angleB))",
              @"$sideC = sqrt(pow($sideA,2)+pow($sideB,2)-2*$sideA*$sideB*cos($angleC))",
              
              // ASA
              @"sideA = $sideC * sin($angleA) / sin($angleC)",
              @"sideB = $sideA * sin($angleB) / sin($angleA)",
              @"sideC = $sideB * sin($angleC) / sin($angleB)",
              
              @"$sideA = sqrt(-2 sqrt(pow($sideB,2) pow($sideC,2)-4 pow($area,2))+pow($sideB,2)+pow($sideC,2))",
              @"$sideB = sqrt(-2 sqrt(pow($sideC,2) pow($sideA,2)-4 pow($area,2))+pow($sideC,2)+pow($sideA,2))",
              @"$sideC = sqrt(-2 sqrt(pow($sideA,2) pow($sideB,2)-4 pow($area,2))+pow($sideA,2)+pow($sideB,2))",
              
              @"$sideA = sqrt(pow(csc($angleB),2) (pow($sideB,2) pow(sin($angleB),2)-sqrt(pow(sin($angleB),2) (pow($sideB,4) pow(sin($angleB),2)+8 pow($sideB,2) $area sin($angleB) cos($angleB)+16 pow($area,2) pow(cos($angleB),2)-16 pow($area,2)))+4 $area sin($angleB) cos($angleB)))/sqrt(2)",
              @"$sideA = sqrt(pow(csc($angleC),2) (pow($sideC,2) pow(sin($angleC),2)-sqrt(pow(sin($angleC),2) (pow($sideC,4) pow(sin($angleC),2)+8 pow($sideC,2) $area sin($angleC) cos($angleC)+16 pow($area,2) pow(cos($angleC),2)-16 pow($area,2)))+4 $area sin($angleC) cos($angleC)))/sqrt(2)",
              @"$sideC = sqrt(pow(csc($angleA),2) (pow($sideA,2) pow(sin($angleA),2)-sqrt(pow(sin($angleA),2) (pow($sideA,4) pow(sin($angleA),2)+8 pow($sideA,2) $area sin($angleA) cos($angleA)+16 pow($area,2) pow(cos($angleA),2)-16 pow($area,2)))+4 $area sin($angleA) cos($angleA)))/sqrt(2)",
              
              ];
}

- (Class)formatterClassForAttribute:(NSString *)attribute
{
    if ([[[self class] attributes] containsObject:attribute]) {
        if ([attribute containsString:@"side"]) {
            return [LengthFormatter class];
        } else if ([attribute containsString:@"angle"]){
            return [AngleFormatter class];
        } else if ([attribute isEqualToString:@"perimeter"]){
            return [LengthFormatter class];
        } else if ([attribute isEqualToString:@"area"]){
            return [AreaFormatter class];
        } else {
            NSAssert(NO, @"");
        }
    }
    return Nil;
}

@end
