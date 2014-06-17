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

+ (NSArray *)groupedAttributes
{
    return @[ @[ @"height", @"width", @"length" ], @[ @"spaceDiagonal", @"volume", @"surfaceArea" ]];
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
             @"$height = ($length (sqrt(pow((2*$volume-$length $surfaceArea),2)-16 pow($length, 3) *$volume)+$length * $surfaceArea+2 $volume))/(-sqrt(pow((2 $volume-$length * $surfaceArea), 2)-16 pow($length, 3) $volume)+4 pow($length,3)+$length * $surfaceArea-2 $volume)",
             @"$height = ($width (sqrt(pow((2*$volume-$width $surfaceArea),2)-16 pow($width, 3) *$volume)+$width * $surfaceArea+2 $volume))/(-sqrt(pow((2 $volume-$width * $surfaceArea), 2)-16 pow($width, 3) $volume)+4 pow($width,3)+$width * $surfaceArea-2 $volume)",

             
             @"$width = sqrt(-pow($height,2)-sqrt(pow($height, 2) (pow($height,6)-2 pow($height, 4) pow($spaceDiagonal, 2)+pow($height, 2) pow($spaceDiagonal, 4)-4 pow($volume, 2)))/pow($height, 2)+pow($spaceDiagonal, 2))/sqrt(2)",
             @"$length = sqrt(-pow($height,2)+sqrt(pow($height,2) (pow($height,6)-2 pow($height,4) pow($spaceDiagonal,2)+pow($height,2) pow($spaceDiagonal,4)-4 pow($volume,2)))/pow($height,2)+pow($spaceDiagonal,2))/sqrt(2)",
             @"$height = sqrt(-pow($length,2)+sqrt(pow($length,2) (pow($length,6)-2 pow($length,4) pow($spaceDiagonal,2)+pow($length,2) pow($spaceDiagonal,4)-4 pow($volume,2)))/pow($length,2)+pow($spaceDiagonal,2))/sqrt(2)",
             @"$height = sqrt(-pow($width,2)+sqrt(pow($width,2) (pow($width,6)-2 pow($width,4) pow($spaceDiagonal,2)+pow($width,2) pow($spaceDiagonal,4)-4 pow($volume,2)))/pow($width,2)+pow($spaceDiagonal,2))/sqrt(2)",
             
             @"$length = 1/2*sqrt(-3 pow($height,2)+(2 $height pow($spaceDiagonal,2))/sqrt(pow($spaceDiagonal,2)+$surfaceArea)+(2*$height*$surfaceArea)/sqrt(pow($spaceDiagonal, 2)+$surfaceArea)+pow($spaceDiagonal, 2)-$surfaceArea)-$height/2+sqrt(pow($spaceDiagonal, 2)+$surfaceArea)/2",
             @"$height = 1/2*sqrt(-3 pow($length,2)+(2 $length pow($spaceDiagonal,2))/sqrt(pow($spaceDiagonal,2)+$surfaceArea)+(2*$length*$surfaceArea)/sqrt(pow($spaceDiagonal, 2)+$surfaceArea)+pow($spaceDiagonal, 2)-$surfaceArea)-$length/2+sqrt(pow($spaceDiagonal, 2)+$surfaceArea)/2",
             @"$height = 1/2*sqrt(-3 pow($width,2)+(2 $width pow($spaceDiagonal,2))/sqrt(pow($spaceDiagonal,2)+$surfaceArea)+(2*$width*$surfaceArea)/sqrt(pow($spaceDiagonal, 2)+$surfaceArea)+pow($spaceDiagonal, 2)-$surfaceArea)-$width/2+sqrt(pow($spaceDiagonal, 2)+$surfaceArea)/2"

             
       ];
}

@end
