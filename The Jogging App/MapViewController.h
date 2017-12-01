//
//  SecondViewController.h
//  The Jogging App
//
//  Created by Ricardo Pereira Marques da Silva [el16rlpm] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *location;
@property(nonatomic) MKMapType mapType;

- (IBAction)mapViewButton:(UIButton *)sender;
- (IBAction)satelliteViewButton:(UIButton *)sender;
- (IBAction)hybridViewButton:(UIButton *)sender;



@end

