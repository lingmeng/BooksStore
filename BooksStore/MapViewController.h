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
#import "W_A_M_HomeViewController.h"

@class W_A_M_HomeViewController;

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

@property(nonatomic, retain) W_A_M_HomeViewController *wamhomeVc;

- (void)mapLoadView:(int)pages latitude:(float)latitude longitude:(float)longitude;

- (IBAction)changeMapType:(id)sender;

@end
