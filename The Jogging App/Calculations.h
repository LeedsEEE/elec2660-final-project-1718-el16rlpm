//
//  Calculations.h
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 27/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhysicalViewController.h"
#import "MapViewController.h"

@interface Calculations : NSObject
@property float caloriesPerMeter;
@property (readwrite, nonatomic) float weightLost;
@property float distance;
@property (readwrite, nonatomic) float BMRVal;
@property (readwrite, nonatomic) float BMR;
@property (readwrite, nonatomic) float caloriesBurned;
- (double)setBMR:(float)height :(float)weight :(float)age :(BOOL)gender;
- (double)getCaloriesBurned:(float)dist;
- (double)getWeightLost;
@end
