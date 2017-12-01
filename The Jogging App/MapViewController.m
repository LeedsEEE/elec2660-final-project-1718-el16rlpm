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

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"User Location = %f, %f", userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate,MKCoordinateSpanMake(0.1,0.1));
    self.startCoord = userLocation.coordinate;
    self.userLoc = userLocation.coordinate;
    [self.mapView setRegion:region animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate: self.startCoord];
    [self.mapView addAnnotation: annotation];
}

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier: @"myPin"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"myPin"];
    } else {
        pin.annotation = annotation;
    }
    //:pin.annotation = annotation;
    pin.animatesDrop = YES;
    pin.draggable = YES;
    
    
    
    return pin;
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        
        CLLocationCoordinate2D targetLoc = annotationView.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", targetLoc.latitude, targetLoc.longitude);
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = targetLoc;
        NSArray *existingpoints = mapView.annotations;
        if ([existingpoints count] == 2){
            self.startCoord = targetLoc;
            [annotation setCoordinate: self.userLoc];
        }
        if ([existingpoints count] == 3) {
            [annotation setCoordinate: self.userLoc];
            MKPlacemark *placemarkStart = [[MKPlacemark alloc]initWithCoordinate:self.startCoord addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
            MKMapItem *sourceItem = [[MKMapItem alloc]initWithPlacemark:placemarkStart];
            [sourceItem setName:@"Jog Path Start"];
            MKPlacemark *placemarkDest = [[MKPlacemark alloc]initWithCoordinate:targetLoc addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
            MKMapItem *destItem = [[MKMapItem alloc]initWithPlacemark:placemarkDest];
            [destItem setName:@"Jog Path Target"];
            [mapView removeAnnotations:existingpoints];
            [mapView removeOverlays:mapView.overlays];
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
            [request setSource:sourceItem];
            [request setDestination:destItem];
            [request setTransportType:MKDirectionsTransportTypeWalking];
            [request setRequestsAlternateRoutes:YES];
            MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                /*if (!error) {
                 for (MKRoute *route in [response routes]) {
                 [mapView addOverlay:[route polyline] level:MKOverlayLevelAboveRoads]; // Draws the route above roads, but below labels.
                 // You can also get turn-by-turn steps, distance, advisory notices, ETA, etc by accessing various route properties.
                 }
                 }*/
                NSLog(@"response = %@",response);
                NSArray *arrRoutes = [response routes];
                [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    MKRoute *rout = obj;
                    MKPolyline *line = [rout polyline];
                    [self.mapView addOverlay:line];
                    /*MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:line];
                     [renderer setStrokeColor:[UIColor redColor]];
                     [renderer setLineWidth:5.0];*/
                    NSLog(@"Rout Name : %@",rout.name);
                    NSLog(@"Total Distance (in Meters) :%f",rout.distance);
                    [self.distanceLabel setText:[NSString stringWithFormat:@"Distance: %.1fm", rout.distance]];
                    [self.timeLabel setText:[NSString stringWithFormat:@"Estimated Time: %.1fm", 60*rout.distance/7.36]];
                }];
            }];
        }
        [self.mapView addAnnotation:annotation];
        
    }
}



- (IBAction)mapViewButton:(UIButton *)sender {
    self.mapView.mapType = MKMapTypeStandard;
}

- (IBAction)satelliteViewButton:(UIButton *)sender {
    self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)hybridViewButton:(UIButton *)sender {
    self.mapView.mapType = MKMapTypeHybrid;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor redColor]];
        [renderer setLineWidth:3.0];
        return renderer;
    }
    return nil;
}

@end
