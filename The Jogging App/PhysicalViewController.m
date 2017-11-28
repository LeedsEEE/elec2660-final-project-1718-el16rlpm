//
//  FirstViewController.m
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "PhysicalViewController.h"
#import "Calculations.h"


@interface PhysicalViewController ()

@end
@implementation PhysicalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.weight = [self.weightTextField.text doubleValue];
    self.height = [self.heightTextField.text doubleValue];
    self.age = [self.ageTextField.text doubleValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)helpButton:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"How to input information" message:@"Basal Metabolic Rate is how many calories you burn per day while at rest. If you don't know this value, the averages are 1662 kcal for Men, 2000 kcal for Women." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
/*- (IBAction)onSegmentValueChanged:(UISegmentedControl *)sender {
 UISegmentedControl *seg = (UISegmentedControl *)sender;
 if (seg.selectedSegmentIndex == 0) {
 self.gender = 0;
 }
 else {
 self.gender = 1;
 }
 if (self.age != 0) {
 Calculations *c=[[Calculations alloc] init];
 ;
 [self.BMRLabel setText:[NSString stringWithFormat:@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]]];
 NSLog(@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]);
 }
 }*/


#pragma mark Text Field Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //:if ([self.weightTextField isFirstResponder]) {
    self.weight = [self.weightTextField.text doubleValue];
    //:}
    //:if ([self.heightTextField isFirstResponder]) {
    self.height = [self.heightTextField.text doubleValue];
    //:}
    //:if ([self.caloricInTextField isFirstResponder]) {
    self.age = [self.ageTextField.text doubleValue];
    //:}
    
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
        }
        NSLog(@"BMI: %.1f", self.BMI);
    }
    
    [textField resignFirstResponder];
    
    
    return YES;
    
}

- (IBAction)backgroundPressed:(id)sender {
    if ([self.weightTextField isFirstResponder]) {
        
        [self.weightTextField resignFirstResponder];
    }
    if ([self.heightTextField isFirstResponder]) {
        
        [self.heightTextField resignFirstResponder];
    }
    if ([self.ageTextField isFirstResponder]) {
        
        [self.ageTextField resignFirstResponder];
    }
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
        }
        //:NSLog(@"BMI: %.1f", self.BMI);
        if (self.age != 0) {
            Calculations *c=[[Calculations alloc] init];
            ;
            [self.BMRLabel setText:[NSString stringWithFormat:@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]]];
            NSLog(@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]);
        }
    }
    
}

- (IBAction)genderChanged:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    if (seg.selectedSegmentIndex == 0) {
        self.gender = 0;
    }
    else {
        self.gender = 1;
    }
    if (self.age != 0) {
        Calculations *c=[[Calculations alloc] init];
        ;
        [self.BMRLabel setText:[NSString stringWithFormat:@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]]];
        NSLog(@"BMR: %.1f", [c setBMR: self.height: self.weight: self.age: self.gender]);
    }
}
@end

