//
//  FirstViewController.m
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Tab bar icons and App icon created using draw.io

#import "PhysicalViewController.h"
#import "Calculations.h"


@interface PhysicalViewController ()

@end
@implementation PhysicalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.weightTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"weightText"];
    self.heightTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"heightText"];
    self.ageTextField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"ageText"];
    self.genderControl.selectedSegmentIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"genderSeg"];
    [self.BMILabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"BMIText"]];
    [self.BMRLabel setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"BMRText"]]; //Defaults for last input information, height, weight, age textfields, gender, and BMI, BMR labels.
    
    self.weight = [self.weightTextField.text doubleValue];
    self.height = [self.heightTextField.text doubleValue];
    self.age = [self.ageTextField.text doubleValue]; //sets the weight, height, age values to the textfield input
    
    if ((self.weight)&&(self.height)&&(self.age)) {
    Calculations *c=[[Calculations alloc] init];
    [c setBMR: self.height: self.weight: self.age: self.gender]; //runs the BMR ratio, if the user already has the defaults
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)helpButton:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"How to input information" message:@"In this tab, input your physical information: weight, height, age, and gender. This will calculate your BMI ratio, as well as your BMR (Basal Metabolic Rate - How many calories you consume daily if at rest). This information will be used to calculate your route's caloric deficit, and the weight you would lose." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
                //code for a UIAlert for when the user presses the button, animated, and with an ok button that closes it
}



#pragma mark Textfield Responder
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    

    self.weight = [self.weightTextField.text doubleValue];

    self.height = [self.heightTextField.text doubleValue];

    self.age = [self.ageTextField.text doubleValue];        //Apply age, height, and weight values from textfield values

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.weightTextField.text forKey:@"weightText"];
    [defaults setObject:self.heightTextField.text forKey:@"heightText"];
    [defaults setObject:self.ageTextField.text forKey:@"ageText"];
    [defaults setInteger:self.genderControl.selectedSegmentIndex forKey:@"genderSeg"];
    [defaults synchronize];                                 //Apply the values to defaults, so it is remembered next time
    
    if ((self.weight != 0)&&(self.height != 0)) {
        self.BMI = self.weight/(self.height * self.height);
        if (self.BMI <= 18.5) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Underweight", self.BMI]];
        }
        if ((self.BMI > 18.5)&&(self.BMI <= 25)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Healthy Weight", self.BMI]];
        }
        if ((self.BMI > 25)&&(self.BMI <= 30)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Overweight", self.BMI]];
        }
        if ((self.BMI > 30)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Obese", self.BMI]];
        }               // Calculate BMI if values for weight and height are available, change BMI label to those values
        NSLog(@"BMI: %.1f", self.BMI);
        [defaults setObject:self.BMILabel.text forKey:@"BMIText"];
        [defaults synchronize];                                                 //save BMI label for next time its open
    }
    
    [textField resignFirstResponder];                           // if return pressed on the keyboard, close the keyboard
    
    
    return YES;
    
}

#pragma mark Background pressed responder
- (IBAction)backgroundPressed:(id)sender {
    if ([self.weightTextField isFirstResponder]) {
        
        [self.weightTextField resignFirstResponder];
    }
    if ([self.heightTextField isFirstResponder]) {
        
        [self.heightTextField resignFirstResponder];
    }
    if ([self.ageTextField isFirstResponder]) {
        
        [self.ageTextField resignFirstResponder];
    }                                                           //close any keyboard if the user presses the background
    self.weight = [self.weightTextField.text doubleValue];
    self.height = [self.heightTextField.text doubleValue];
    self.age = [self.ageTextField.text doubleValue];
    if ((self.weight != 0)&&(self.height != 0)) {
        self.BMI = self.weight/(self.height * self.height);
        if (self.BMI <= 18.5) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Underweight", self.BMI]];
        }
        if ((self.BMI > 18.5)&&(self.BMI <= 25)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Healthy Weight", self.BMI]];
        }
        if ((self.BMI > 25)&&(self.BMI <= 30)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Overweight", self.BMI]];
        }
        if ((self.BMI > 30)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Obese", self.BMI]];
        }                 // Calculate BMI if values for weight and height are available, change BMI label to those values
        
        if (self.age != 0) {
            Calculations *c=[[Calculations alloc] init];
            ;
            [self.BMRLabel setText:[NSString stringWithFormat:@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]]];
            NSLog(@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]);
            //if there is a value for age, get the BMR value. Done by calling the method in the calculations class with the right parameters
        }
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.weightTextField.text forKey:@"weightText"];
    [defaults setObject:self.heightTextField.text forKey:@"heightText"];
    [defaults setObject:self.ageTextField.text forKey:@"ageText"];
    [defaults setInteger:self.genderControl.selectedSegmentIndex forKey:@"genderSeg"];
    [defaults setObject:self.BMILabel.text forKey:@"BMIText"];
    [defaults setObject:self.BMRLabel.text forKey:@"BMRText"];
    [defaults synchronize];                                                                         //save new defaults
}

#pragma mark Gender segment control
- (IBAction)genderChanged:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    if (seg.selectedSegmentIndex == 0) {
        self.gender = 0;                            //assign 0 bool for male
    }
    else {
        self.gender = 1;                            //assign 1 bool for female
    }
    if (self.age != 0) {
        Calculations *c=[[Calculations alloc] init];
        ;
        [self.BMRLabel setText:[NSString stringWithFormat:@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]]];
        NSLog(@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]);
                                //update BMR value when segmented control is changed (only when age value is available)
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.weightTextField.text forKey:@"weightText"];
    [defaults setObject:self.heightTextField.text forKey:@"heightText"];
    [defaults setObject:self.ageTextField.text forKey:@"ageText"];
    [defaults setInteger:self.genderControl.selectedSegmentIndex forKey:@"genderSeg"];
    [defaults synchronize];                                                                         //update defaults
}
@end

