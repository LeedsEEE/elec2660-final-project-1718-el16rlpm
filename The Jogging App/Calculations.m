//
//  Calculations.m
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 27/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "Calculations.h"
#import "PhysicalViewController.h"


@implementation Calculations
@synthesize BMR;

- (double)setBMR:(float)height :(float)weight :(float)age :(BOOL)gender{
    if (gender == 0) {
        self.BMR = 66.47 + (13.7*weight) + (500*height) - (6.8*age);
    }
    if (gender == 1) {
        self.BMR = 655.1 + (9.6*weight) + (180*height) - (4.7*age);
    }
    return self.BMR;
}
@end
