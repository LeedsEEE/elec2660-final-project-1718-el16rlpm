//
//  FirstViewController.m
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "PhysicalViewController.h"

@interface PhysicalViewController ()

@end

@implementation PhysicalViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)helpButton:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"How to input information" message:@"For this textbox, input the amount of calories you can eat per day and not gain or lose any weight. If you don't know this value, the averages are 2500 kcal for Men, 2000 kcal for Women." preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark Text Field Delegates
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([self.weightTextField isFirstResponder]) {
        self.weight = [self.weightTextField.text doubleValue];
    }
    if ([self.heightTextField isFirstResponder]) {
        self.height = [self.heightTextField.text doubleValue];
    }
    if ([self.caloricInTextField isFirstResponder]) {
        self.caloricIn = [self.caloricInTextField.text doubleValue];
    }
    
    if ((self.weight != 0)&&(self.height != 0)) {
        self.BMI = self.weight/(self.height * self.height);
        if (self.BMI <= 18.5) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Underweight", self.BMI]];
        }
        if ((self.BMI > 18.5)&&(self.BMI <= 25)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Healthy Weight", self.BMI]];
        }
        if ((self.BMI > 25)&&(self.BMI <= 30)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Healthy Weight", self.BMI]];
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
        if ([self.weightTextField isFirstResponder]) {
            self.weight = [self.weightTextField.text doubleValue];
        }

        [self.weightTextField resignFirstResponder];
    }
    if ([self.heightTextField isFirstResponder]) {
        if ([self.heightTextField isFirstResponder]) {
            self.height = [self.heightTextField.text doubleValue];
        }
        [self.heightTextField resignFirstResponder];
    }
    if ([self.caloricInTextField isFirstResponder]) {
        if ([self.caloricInTextField isFirstResponder]) {
            self.caloricIn = [self.caloricInTextField.text doubleValue];
        }
        [self.caloricInTextField resignFirstResponder];
    }
    if ((self.weight != 0)&&(self.height != 0)) {
        self.BMI = self.weight/(self.height * self.height);
        if (self.BMI <= 18.5) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Underweight", self.BMI]];
        }
        if ((self.BMI > 18.5)&&(self.BMI <= 25)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Healthy Weight", self.BMI]];
        }
        if ((self.BMI > 25)&&(self.BMI <= 30)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Healthy Weight", self.BMI]];
        }
        if ((self.BMI > 30)) {
            [self.BMILabel setText:[NSString stringWithFormat:@"BMI: %.1f - Obese", self.BMI]];
        }
        NSLog(@"BMI: %.1f", self.BMI);
    }
    
}

@end

