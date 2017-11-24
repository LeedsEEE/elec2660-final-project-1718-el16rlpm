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
@property float caloricIn;
@property float BMI;

- (IBAction)helpButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *BMILabel;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *caloricInTextField;
- (IBAction)backgroundPressed:(id)sender;
@end

