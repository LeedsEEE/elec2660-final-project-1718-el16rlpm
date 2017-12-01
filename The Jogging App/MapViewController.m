//
//  SecondViewController.m
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
@property (nonatomic,strong) MKPlacemark *startLoc;
@property (nonatomic,strong) MKPlacemark *destLoc;
@property  CLLocationCoordinate2D startCoord;
@property CLLocationCoordinate2D userLoc;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.location = [[CLLocationManager alloc] init];
    self.mapView.delegate = self;
    self.location.delegate = self;
    
    [self.location requestWhenInUseAuthorization];
    
    self.mapView.showsUserLocation = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)mapViewButton:(UIButton *)sender {
}

- (IBAction)satelliteViewButton:(UIButton *)sender {
}

- (IBAction)hybridViewButton:(UIButton *)sender {
}

@end
