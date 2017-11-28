//
//  FirstViewController.h
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhysicalViewController : UIViewController <UITextFieldDelegate>

@property float weight;
@property float height;
@property float age;
@property float BMI;
@property BOOL gender;

- (IBAction)helpButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *BMILabel;
@property (weak, nonatomic) IBOutlet UILabel *BMRLabel;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
- (IBAction)genderChanged:(id)sender;


@end

