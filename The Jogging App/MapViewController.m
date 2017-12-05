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
    self.location = [[CLLocationManager alloc] init]; //Initialise Location manager, used for user location
    self.mapView.delegate = self;
    self.location.delegate = self;                    //Delegates for mapview and location are this view controller
    
    [self.location requestWhenInUseAuthorization];    //Ask for permission to get user location
    
    self.mapView.showsUserLocation = YES;             //Displays annotation of user's location
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark User updates location
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"User Location = %f, %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate,MKCoordinateSpanMake(0.1,0.1)); //create a rectangle with scale 0.1,0.1
    
    [self.mapView setRegion:region animated:YES]; //set region to the previous rectangle, animated
    
    self.startCoord = userLocation.coordinate;
    self.userLoc = userLocation.coordinate; //set variables for user location
    
    //MKAnnotationView* userLocationPin = [mapView viewForAnnotation:userLocation];
    
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate: self.startCoord];
    [self.mapView addAnnotation: annotation];
    [mapView selectAnnotation:annotation animated:YES]; //create an annotation pin on the user's location and select
    
    
    [self.instLabel setText:@"Place any pin at start location"]; //display instructions on label
}

#pragma mark Annotation View properties
- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        ((MKUserLocation *)annotation).title = @""; //disable textbox for user location annotation
        return nil;
    }
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier: @"myPin"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"myPin"];
    } else {
        pin.annotation = annotation;
    }
    pin.animatesDrop = YES;
    pin.draggable = YES;
    
    
    
    
    return pin; //properties for an animated, draggable annotation pin, with identifier. Syntax and methodology for setting up draggable properties referenced from https://stackoverflow.com/questions/11927692/ios-mkmapview-draggable-annotations
}

#pragma mark Pin got dragged
- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding) //If the pin got dragged and dropped
    {
        
        CLLocationCoordinate2D targetLoc = annotationView.annotation.coordinate; //save current location
        NSLog(@"Pin dropped at %f,%f", targetLoc.latitude, targetLoc.longitude);
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = targetLoc;                                      //Initialise an annotation with the location coordinates
        NSArray *existingpoints = mapView.annotations;                          //create an array with all the exiting annotation pins
        if ([existingpoints count] == 2){
            self.startCoord = targetLoc;
            [self.instLabel setText:@"Place any pin at end location"];
            [annotation setCoordinate: self.userLoc];                          //if there is one annotation pin (user location icon counts as 1), this means we are placing the second pin. Set this location as the target
        }
        if ([existingpoints count] == 3) {
            [self.instLabel setText:[NSString stringWithFormat:@"Done! Drag any pin if you \nwant a new start location"]];
            [annotation setCoordinate: self.userLoc];                          //save location to variable
            MKPlacemark *placemarkStart = [[MKPlacemark alloc]initWithCoordinate:self.startCoord addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
            MKMapItem *sourceItem = [[MKMapItem alloc]initWithPlacemark:placemarkStart];
            [sourceItem setName:@"Jog Path Start"];                 //create a placemark object for the start coordinate
            MKPlacemark *placemarkDest = [[MKPlacemark alloc]initWithCoordinate:targetLoc addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
            MKMapItem *destItem = [[MKMapItem alloc]initWithPlacemark:placemarkDest];
            [destItem setName:@"Jog Path Target"];                      //create a placemark object for the end coordinate
            [mapView removeAnnotations:existingpoints];
            [mapView removeOverlays:mapView.overlays];                                  //remove old pins and drawn routes
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];          //initialise a directions request
            [request setSource:sourceItem];
            [request setDestination:destItem];
            [request setTransportType:MKDirectionsTransportTypeWalking];
            [request setRequestsAlternateRoutes:YES];
            MKDirections *directions = [[MKDirections alloc] initWithRequest:request];  //properties of directions request: from the source placemark to the destination placemark, using walking directions
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {//directions handler - syntax for initialising handler and available routes referenced from http://www.technetexperts.com/mobile/draw-route-between-2-points-on-map-with-ios7-mapkit-api/
                NSLog(@"response = %@",response);
                NSArray *arrayRoutes = [response routes]; //save all the routes to an array
                [arrayRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { //enumerate the routes to choose one
                    MKRoute *route = obj; //create a route object from the directions recieved
                    MKPolyline *line = [route polyline]; //create a line object to render the route
                    [self.mapView addOverlay:line]; //add an overlay to the map view with the rendered line
                    NSLog(@"Route Name : %@",route.name);
                    NSLog(@"Total Distance (in Meters) :%f",route.distance);
                    [self.distanceLabel setText:[NSString stringWithFormat:@"Distance: %.2fkm", route.distance/1000.00]];
                    [self.timeLabel setText:[NSString stringWithFormat:@"Estimated Time: %.1fmin", 60.00*(route.distance/1000.00)/7.36]]; //set the labels to their appropiate values (distance, time)
                    Calculations *c=[[Calculations alloc] init];
                    [self.caloriesBurnedLabel setText:[NSString stringWithFormat:@"Calories Burned: %.1fkcal", [c getCaloriesBurned: route.distance]]];
                    [self.weightLostLabel setText:[NSString stringWithFormat:@"Weight lost per                week if run daily: %.2fkg", [c getWeightLost]]];
                    //set the calculations labels to their values, calling methods from the calculations class
                    
                }];
            }];
        }
        [self.mapView addAnnotation:annotation]; //add and select an annotation pin based on previous properies
        [mapView selectAnnotation:annotation animated:YES];
        
    }
}


#pragma mark Map View Type buttons
- (IBAction)mapViewButton:(UIButton *)sender {
    self.mapView.mapType = MKMapTypeStandard; //set map to standard map
}

- (IBAction)satelliteViewButton:(UIButton *)sender {
    self.mapView.mapType = MKMapTypeSatellite; //set map to satellite map
}

- (IBAction)hybridViewButton:(UIButton *)sender {
    self.mapView.mapType = MKMapTypeHybrid; //set map to hybrid map
}

#pragma mark Renderer properties
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay]; //initialise a renderer object
        [renderer setStrokeColor:[UIColor redColor]]; //set the line color to red
        [renderer setLineWidth:3.0]; //set the line width to 3.0
        return renderer;
    }
    return nil;
}

@end
