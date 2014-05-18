//
//  Cuboid.m
//  MathCalc
//
//  Created by Johannes Lund on 2014-05-18.
//  Copyright (c) 2014 anviking. All rights reserved.
//

#import "Cuboid.h"

@implementation Cuboid

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"Cuboid";
    }
    return self;
}

+ (NSArray *)attributes
{
    return @[ @"height",
              @"width",
              @"length",
              @"spaceDiagonal",
              @"volume",
              @"surfaceArea" ];
}

- (NSArray *)formulaStrings {
    return @[ // Volume
             @"$volume = $height * $width * $length",
             @"$height = $volume / ($width * $length)",
             @"$width = $volume / ($height * $length)",
             @"$length = $volume / ($width * $height)",
             
             // Surface Area
             @"$surfaceArea = 2*$height*$width + 2*$height*$length + 2*$width*$length",
             @"$height = ($surfaceArea - 2 * $length * $width) / (2($length + $width))",
             @"$width = ($surfaceArea - 2 * $length * $height) / (2($length + $height))",
             @"$length = ($surfaceArea - 2 * $height * $width) / (2($height + $width))",
             
             // Space Diagonal
             @"$spaceDiagonal = sqrt(pow($height, 2) + pow($width, 2) + pow($length, 2))",
             @"$height = sqrt(pow($spaceDiagonal, 2) - pow($width, 2) - pow($length, 2))",
             @"$length = sqrt(pow($spaceDiagonal, 2) - pow($width, 2) - pow($height, 2))",
             @"$width = sqrt(pow($spaceDiagonal, 2) - pow($height, 2) - pow($length, 2))",
             
             @"$length = ($height (sqrt(pow((2*$volume-$height $surfaceArea),2)-16 pow($height, 3) *$volume)+$height * $surfaceArea+2 $volume))/(-sqrt(pow((2 $volume-$height * $surfaceArea), 2)-16 pow($height, 3) $volume)+4 pow($height,3)+$height * $surfaceArea-2 $volume)",
             
             @"$width = sqrt(-pow($height,2)-sqrt(pow($height, 2) (pow($height,6)-2 pow($height, 4) pow($spaceDiagonal, 2)+pow($height, 2) pow($spaceDiagonal, 4)-4 pow($volume, 2)))/pow($height, 2)+pow($spaceDiagonal, 2))/sqrt(2)"];
}

@end
