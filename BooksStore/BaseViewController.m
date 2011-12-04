//
//  BaseViewController.m
//  BookStore
//
//  Created by meng ling on 11-11-1.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
@synthesize managedObjectContext;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)getDocumentDirectory {  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);  
    return [paths objectAtIndex: 0];  
} 
//开启同步sychronizedAndSaveToDB
-(NSInteger)needSychronize{
    /*
     <VERSION>
        <BOOKSTOREVERSION>1
        </BOOKSTOREVERSION>
        <BOOKSTOREGROUPVERSION>1
        </BOOKSTOREGROUPVERSION>
     <VERSION>
     */
    NSError* error;
    NSString *xmlFromServ=@"<VERSION><BOOKSTOREVERSION>1</BOOKSTOREVERSION><BOOKSTOREGROUPVERSION>1</BOOKSTOREGROUPVERSION></VERSION>";
    GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithXMLString:xmlFromServ options:0 error:&error];
	GDataXMLElement *rootNode = [document rootElement];
    NSArray  *bookversion = [rootNode nodesForXPath:@"//VERSION/BOOKSTOREVERSION" error:&error];
    NSArray  *bookgroupversion = [rootNode nodesForXPath:@"//VERSION/BOOKSTOREGROUPVERSION" error:&error];
   
    //下载报文判断版本号
    NSNumber *serv=(NSNumber *)[[bookversion objectAtIndex:0]stringValue];
    NSNumber *servg=(NSNumber *)[[bookgroupversion objectAtIndex:0]stringValue];
    
    NSLog(@"a %d,b %d",[serv intValue],[servg intValue]);
   
    //获取本机版本号
    NSString *documentDirectory = [self getDocumentDirectory];  
    NSString *fileName = @"BSysVersion.plist";  
    NSString *finalPath = [documentDirectory stringByAppendingPathComponent: fileName];  
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalPath]) {
        finalPath = [[NSBundle mainBundle] pathForResource:@"BSysVersion" ofType:@"plist"];
    }
    //NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:finalPath];
    NSMutableDictionary *topRoot = [[NSMutableDictionary alloc] initWithContentsOfFile: finalPath];  
    
    //根据版本号判断是否需要同步
    NSNumber *bsv=(NSNumber *)[topRoot objectForKey:@"BookStoreVersion"];
    NSNumber *bsgv=(NSNumber *)[topRoot objectForKey:@"BookStoreGroupVersion"];
    if (([bsv intValue]==1||[serv intValue]>[bsv intValue])&&([bsgv intValue]==1||[servg intValue]>[bsgv intValue])) {
        //NSLog(@"need update bookstore");
        return NeedUpdateALL;//类型和杂志均需更新
    }
    else if ([bsgv intValue]==1||[servg intValue]>[bsgv intValue]) {
        return NeedUpdateBookStoreGroup;//类型需更新
    }
    else if ([bsgv intValue]==1||[servg intValue]>[bsgv intValue]) {
        return NeedUpdateBookStore;//杂志需更新
    }
    else 
    return NeedUpdateNothing;//无需更新
}
-(Boolean)sychronizeWithServ:(int)flag{
    if (flag==NeedUpdateALL) {
        NSLog(@"dsds");
    }
    return YES;
}

- (id)initWithPageNumber:(int)page {
    /*if (page==0) {
        if (self = [super initWithNibName:@"FrontCoverView" bundle:nil])
        {// NSLog(@"iiiFrontCoverView count:%d",[self retainCount]);
            pageNumber = page; return self;
        }
    }*/
    if (self = [super initWithNibName:@"BaseViewController" bundle:nil])
    {
        
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) hideTabBar:(BOOL) hidden
{  
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    //NSLog(@"count: %d",[self.tabBarController.view.subviews count]);
    
   /* if (self.view.tag==9991) {
       //NSLog(@"count: %d",[self.tabBarController.view.subviews count]);
        //[NSLog(@"count: %d",[self.tabBarController.view.subviews count]);
       // NSLog(@"aabb");
        for(UIView *view2 in self.tabBarController.view.subviews){
              
            for(UIView *view in view2.subviews)
           // NSLog([view class])
            if([view isKindOfClass:[UITabBar class]])
            {
               // NSLog(@"bb");
                if (hidden) {
                   // NSLog(@"bbcc");
                    [view setFrame:CGRectMake(view.frame.origin.x, 768, view.frame.size.width, view.frame.size.height)];
                } else {
                   // NSLog(@"bbdd");
                    [view setFrame:CGRectMake(view.frame.origin.x, 768-49, view.frame.size.width, view.frame.size.height)];
                }
            } 
        }
    }
    
    else
    {*/
    
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
       // NSLog(@"bbyy");
       // view.backgroundColor=[UIColor redColor];
        if([view isKindOfClass:[UITabBar class]])
        {
          //  NSLog(@"bbmm");
            if (hidden) {
               // NSLog(@"bbzz");
                [view setFrame:CGRectMake(view.frame.origin.x, 768, view.frame.size.width, view.frame.size.height)];
            } else {
              //  NSLog(@"bbxx");
              
                [view setFrame:CGRectMake(view.frame.origin.x, 768-49, view.frame.size.width, view.frame.size.height)];
            }
        } 
        else 
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 768)];
            } else {
                
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 768-49)];
            }
        }
        
    //}
}
    [UIView commitAnimations];
}
bool ishidden=NO;
-(void)hideBar{
    
    if (ishidden) {
        
        [self hideTabBar:NO];
        ishidden=NO;
    }
    else
    { 
        
        [self hideTabBar:YES];
        ishidden=YES;
    }
}
#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }
	return NO;
}


#pragma mark - on touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   //  NSLog(@"touch view++++++");
    /*NSSet *allTouches = [event allTouches];
    UITouch *touch = [touches anyObject];
    
    NSLog(@"touch view++++++%@", [touch view]);*/
    //[self hideBar];
//    NSLog(@"touch view++++++--");
    // [touch view]获得当前touch的view
    
    //[allTouches count]获得当前touch的是否是多触摸，如果 [allTouches count] == 1就不是多触摸。
    
}



//是指触摸移动时，调touchesMoved

#define ZOOM_IN_TOUCH_SPACING_RATIO       (0.75)
#define ZOOM_OUT_TOUCH_SPACING_RATIO      (1.5)

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //获取当前touch的点
   // CGPoint location = [touch locationInView:self];
   /* 
    switch ([allTouches count])
    {
        case 1: 
        {
        }
            break;
        case 2: 
        {
            UITouch *touch0 = [[allTouches allObjects] objectAtIndex:0];
            UITouch *touch1 = [[allTouches allObjects] objectAtIndex:1];
            CGFloat spacing = 
            [self eucledianDistanceFromPoint:[touch0 locationInView:self] 
                                     toPoint:[touch1 locationInView:self]];
            CGFloat spacingRatio = spacing / lastTouchSpacing_;
            
            if (spacingRatio >= ZOOM_OUT_TOUCH_SPACING_RATIO){
                [self zoomIn]; 
                
            }
            else if (spacingRatio <= ZOOM_IN_TOUCH_SPACING_RATIO) {
                [self zoomOut];
            }
        }
            break;
        default:
            break;
    }
    */
}



//结束时调用touchesEnded

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
