//
//  MapViewController.m
//  World_Architect_Magazine
//
//  Created by ZhanJun on 11-11-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

@synthesize mapView;
@synthesize mapTypeContrl;
@synthesize myPlace;;
@synthesize myGeocoder; 
@synthesize imaagemap;
@synthesize imageview;
@synthesize wamhomeVc;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
#define button_Width 37
#define button_Height 36
#define map_button_top 660
#define map_button_left 38

- (void) initMapView {  
    NSArray *buttonNames = [NSArray arrayWithObjects:@"地图", @"卫星", @"地形", nil]; 
    mapTypeContrl = [[UISegmentedControl alloc] initWithItems:buttonNames];
    mapTypeContrl.selectedSegmentIndex=0; 
    mapTypeContrl.segmentedControlStyle = UISegmentedControlStyleBar;
    mapTypeContrl.frame = CGRectMake(873, 715, 150, 30);
    mapTypeContrl.tag = 230;
    mapTypeContrl.userInteractionEnabled = YES;
    [mapTypeContrl addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    [mapView addSubview:mapTypeContrl];
    
    
}  
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    wamhomeVc = [[W_A_M_HomeViewController alloc] init];
    [wamhomeVc setMapVc:self];
    
    self.view.userInteractionEnabled = YES;
    self.view.frame = CGRectMake(0, 0, 280, 180);
    self.view.backgroundColor = [UIColor colorWithRed:109/255 green:109/255 blue:109/255 alpha:1.0];
    //    imaagemap = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image1.png"]];
    //    imaagemap.userInteractionEnabled = YES;
    //    imaagemap.frame =CGRectMake(0, 0, 1024,600);
    //    [self.view insertSubview:imaagemap aboveSubview:mapView];
    //    mapBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    //    mapBtu.frame = CGRectMake(map_button_left, map_button_top - 150, button_Width, button_Height);
    //    [mapBtu setImage:[UIImage imageNamed:@"btn-ditu.png"] forState:UIControlStateNormal];
    //    [mapBtu addTarget:self action:@selector(addMapView:) forControlEvents:UIControlEventTouchUpInside];
    //    [mapBtu setTag:201];
    //    [self.view insertSubview:mapBtu aboveSubview:imaagemap];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    wamhomeVc = nil;
}

- (IBAction)changeMapType:(id)sender
{
    
    //    NSLog(@"why why why why");
    NSInteger index = [(UISegmentedControl *)sender selectedSegmentIndex];
    switch (index) {
        case 0:
            mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            mapView.mapType = MKMapTypeHybrid;
            break;
        default:
            break;
    }
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    myPlace = placemark;
    
    [mapView addAnnotation:placemark];
}




////自定义地图大头针
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    

    myAnnotstionView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];
    // myAnnotstionView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: annotation.title];
    myAnnotstionView.image = [UIImage imageNamed:@"ZUOBIAO.png"];
    myAnnotstionView.canShowCallout=NO;
    myAnnotstionView.animatesDrop = TRUE;
    
    
    return myAnnotstionView;
    
}

int showMap = 0;

- (void)mapLoadView:(int)pages latitude:(float)latitude longitude:(float)longitude;
{
    //    [self.view insertSubview:imaagemap aboveSubview:mapView];
    //    CLLocationCoordinate2D myLocation;+4°29′	+52°09′
    myLocation.latitude = latitude;
    myLocation.longitude = longitude;
    // 将经纬度坐标转换为View坐标. 
    
    
//    if (showMap) {
//        showMap = 0;
//        //        CGPoint userPt = [mapView convertCoordinate:myLocation toPointToView:mapView];
//        //        [self.view insertSubview:mapBtu aboveSubview:imaagemap];
//        //        [mapBtu setImage:[UIImage imageNamed:@"btn-ditu.png"] forState:UIControlStateNormal];
//        //        imaagemap.frame = CGRectMake(userPt.x, userPt.y, 0, 0);
//        //        [UIView beginAnimations:nil context:NULL];
//        //        [UIView setAnimationDuration:0.60f];
//        //        imaagemap.frame =CGRectMake(0, 0, 1024,748);
//        //        [UIView commitAnimations];
//        [mapView removeFromSuperview];
//    }else
//    {
//        showMap = 1;

        mapView = [[MKMapView alloc] init];
//        mapView.frame = CGRectMake(0, 0, 1024, 748);
    mapView.frame =CGRectMake(1, 1, 278, 178);
        mapView.mapType = MKMapTypeStandard;
        mapView.delegate = self;
        mapView.userInteractionEnabled = YES;
  
        MKCoordinateSpan mySpan;
        mySpan.latitudeDelta = 4.51090f;
        mySpan.longitudeDelta = 4.51090f;
        
        myRegion.span = mySpan;
        myRegion.center = myLocation;
        
        myGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:myLocation];
        myGeocoder.delegate = self;
        [myGeocoder start];
        [myGeocoder release];
        myRegion = [mapView regionThatFits:myRegion];
        [mapView setRegion:myRegion animated:TRUE];
        
        [self.view addSubview:mapView];
        //        [self.view insertSubview:imaagemap aboveSubview:mapView];
        //        [self.view insertSubview:mapBtu aboveSubview:imaagemap];
        
        //        CGPoint userPt = [mapView convertCoordinate:myLocation toPointToView:mapView];
        
        //        [mapBtu setImage:[UIImage imageNamed:@"btn-wenzi.png"] forState:UIControlStateNormal];
        //        imaagemap.frame =CGRectMake(0, 0, 1024,748);
        //        [UIView beginAnimations:nil context:NULL];
        //        [UIView setAnimationDuration:0.60f]; 
        //        imaagemap.frame = CGRectMake(userPt.x, userPt.y, 0, 0);        
        //        [UIView commitAnimations];
        
        
        
//        
//        [self initMapView];
//    }
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}




@end
