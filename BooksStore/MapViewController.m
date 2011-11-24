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
    mapTypeContrl.frame = CGRectMake(873, 567, 150, 30);
    mapTypeContrl.tag = 230;
    mapTypeContrl.userInteractionEnabled = YES;
    [mapTypeContrl addTarget:self action:@selector(changeMapType:) forControlEvents:UIControlEventValueChanged];

    

    
    [mapView addSubview:mapTypeContrl];
    
    
}  
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.userInteractionEnabled = YES;
    
    imaagemap = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image1.png"]];
    imaagemap.userInteractionEnabled = YES;
    imaagemap.frame =CGRectMake(0, 0, 1024,600);
    [self.view insertSubview:imaagemap aboveSubview:mapView];
    mapBtu = [UIButton buttonWithType:UIButtonTypeCustom];
    mapBtu.frame = CGRectMake(map_button_left, map_button_top - 150, button_Width, button_Height);
    [mapBtu setImage:[UIImage imageNamed:@"btn-ditu.png"] forState:UIControlStateNormal];
    [mapBtu addTarget:self action:@selector(addMapView:) forControlEvents:UIControlEventTouchUpInside];
    [mapBtu setTag:201];
    [self.view insertSubview:mapBtu aboveSubview:imaagemap];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    myAnnotstionView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"] autorelease];
    
    
    
    imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mark.png"]];
    imageview.frame = CGRectMake(myAnnotstionView.frame.size.width/2.0-10, 0.0-imageview.image.size.height+10, imageview.image.size.width, imageview.image.size.height);
    //名称
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, imageview.frame.size.width,                                                         imageview.frame.size.height-20)];
    labe.backgroundColor = [UIColor clearColor];
    labe.tag = 0x66;
    labe.textColor  = [UIColor whiteColor];
    labe.font = [UIFont systemFontOfSize:12];
    labe.textAlignment = UITextAlignmentCenter;
    labe.text = @"世界建筑导报";
    [imageview addSubview:labe];
    [labe release];

    [myAnnotstionView addSubview:imageview];
    [imageview release];
    myAnnotstionView.animatesDrop = TRUE;
    
    return myAnnotstionView;
    
}

int showMap = 0;

- (void)addMapView:(id)sender
{
    [self.view insertSubview:imaagemap aboveSubview:mapView];
//    CLLocationCoordinate2D myLocation;+4°29′	+52°09′
    myLocation.latitude = 32.07;
    myLocation.longitude = 118.77;
     // 将经纬度坐标转换为View坐标. 


    if (showMap) {
        showMap = 0;
        CGPoint userPt = [mapView convertCoordinate:myLocation toPointToView:mapView];
        [self.view insertSubview:mapBtu aboveSubview:imaagemap];
        [mapBtu setImage:[UIImage imageNamed:@"btn-ditu.png"] forState:UIControlStateNormal];
        imaagemap.frame = CGRectMake(userPt.x, userPt.y, 0, 0);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.60f];
        imaagemap.frame =CGRectMake(0, 0, 1024,600);
        [UIView commitAnimations];
//        [mapView removeFromSuperview];
    }else
    {
        showMap = 1;
        mapView = [[MKMapView alloc] init];
        mapView.frame = CGRectMake(0, 0, 1024, 600);
        
        mapView.mapType = MKMapTypeStandard;
        mapView.delegate = self;
        mapView.userInteractionEnabled = YES;
        
        MKCoordinateSpan mySpan;
        mySpan.latitudeDelta = 0.1;
        mySpan.longitudeDelta = 0.1;
        
        myRegion.span = mySpan;
        myRegion.center = myLocation;
        
        myGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:myLocation];
        myGeocoder.delegate = self;
        [myGeocoder start];
        myRegion = [mapView regionThatFits:myRegion];
        [mapView setRegion:myRegion animated:TRUE];
        
        [self.view addSubview:mapView];
        [self.view insertSubview:imaagemap aboveSubview:mapView];
        [self.view insertSubview:mapBtu aboveSubview:imaagemap];
        
        CGPoint userPt = [mapView convertCoordinate:myLocation toPointToView:mapView];
        
        [mapBtu setImage:[UIImage imageNamed:@"btn-wenzi.png"] forState:UIControlStateNormal];
        imaagemap.frame =CGRectMake(0, 0, 1024,600);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.60f]; 
        imaagemap.frame = CGRectMake(userPt.x, userPt.y, 0, 0);        
        [UIView commitAnimations];
        
        

        
        [self initMapView];
    }
    
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}




@end
