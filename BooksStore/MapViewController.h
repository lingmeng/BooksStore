//
//  MapViewController.h
//  World_Architect_Magazine
//
//  Created by ZhanJun on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import "BaseViewController.h"
@interface MapViewController : BaseViewController<MKAnnotation,MKReverseGeocoderDelegate,MKMapViewDelegate>
{
    MKPinAnnotationView *myAnnotstionView ;
    MKCoordinateRegion myRegion;
    CLLocationCoordinate2D myLocation;
    UIButton *mapBtu;
}

@property(nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) MKReverseGeocoder *myGeocoder;
@property(nonatomic, retain) MKPlacemark *myPlace;

@property(nonatomic, retain) UISegmentedControl *mapTypeContrl;
@property(nonatomic, retain) UIImageView *imaagemap;
@property(nonatomic, retain) UIImageView *imageview;

- (IBAction)changeMapType:(id)sender;
- (void)addMapView:(id)sender;
@end
