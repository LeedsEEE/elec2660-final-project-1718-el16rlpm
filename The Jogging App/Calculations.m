//
//  Calculations.m
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 27/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "Calculations.h"



@implementation Calculations
@synthesize BMR;
@synthesize caloriesBurned;
@synthesize weightLost;

float BMRVal = 0.0;


- (double)setBMR:(float)height :(float)weight :(float)age :(BOOL)gender{
    if (gender == 0) {
        self.BMR = 66.47 + (13.7*weight) + (500*height) - (6.8*age);
    }
    if (gender == 1) {
        self.BMR = 655.1 + (9.6*weight) + (180*height) - (4.7*age);
    }
    BMRVal = self.BMR;
    return self.BMR;
}

float caloriesBurnedVal = 0.0;
-(double)getCaloriesBurned:(float)dist {
    NSLog(@"BMR: %f",BMRVal);
    self.caloriesBurned = BMRVal*(7.0/24.0)*((dist/1000)/7.34);
    NSLog(@"cal: %f",self.caloriesBurned);
    caloriesBurnedVal = self.caloriesBurned;
    return self.caloriesBurned;
}
- (double)getWeightLost{
    self.weightLost = (caloriesBurnedVal/7778)*7;
    return self.weightLost;
}
@end
