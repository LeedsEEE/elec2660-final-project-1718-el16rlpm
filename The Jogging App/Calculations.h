//
//  Calculations.h
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 27/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculations : NSObject
@property float caloriesPerMeter;
@property float caloriesBurned;
@property float weightLost;
@property float distance;
@property (readwrite, nonatomic) float BMR;
- (double)setBMR:(float)height :(float)weight :(float)age :(BOOL)gender;
@end
