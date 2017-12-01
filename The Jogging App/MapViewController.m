//
//  SecondViewController.m
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.location = [[CLLocationManager alloc]init];
    self.mapView.delegate = self;
    self.location.delegate = self;
    [self.location requestWhenInUseAuthorization];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"User Location = %f, %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate,MKCoordinateSpanMake(0.1,0.1));
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)mapViewButton:(UIButton *)sender {
}

- (IBAction)satelliteViewButton:(UIButton *)sender {
}

- (IBAction)hybridViewButton:(UIButton *)sender {
}

@end
