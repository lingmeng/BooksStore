//
//  ReadController.m
//  BookStore
//
//  Created by meng ling on 11-10-26.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ReadController.h"
#import "SecondViewController.h"
@implementation ReadController

@synthesize top_titleView,down_titleView,titleLabel,magazineScrollView,viewControllers;//wamhvc,
NSArray *SkipButtonArray;
int pageNumber=0;
Boolean pageControlUsed = YES;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"阅读", @"阅读");
        self.tabBarItem.image = [UIImage imageNamed:@"阅读"];
      //  self.tabBarController.hidesBottomBarWhenPushed = YES;
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
-(void)loadTabBarItem{
    [self.view addSubview:top_titleView];
    [titleLabel setText:@"dsds"];
    
    down_titleView.frame = CGRectMake(0, 748-38, 1024, 38);

    [self.view addSubview:down_titleView];
}

-(void)loadReadContent{
    /*
     <MAGAZINE>
        <COVER ImageSource="jzzzbg001">
        
        </COVER>
        <ARTICLE NO="1">
          <SKIPBUTTONS>110001001,110001002,110001003,110001004,110001005</SKIPBUTTONS>
           <PAGE ImageSource="jzzzbg002001">年11文章0001按钮001
              <HOTPOINT BtnStartX="120" BtnStartY="120" BtnWidth="123" BtnHeight="345" Ptype="INFOMATION" BtnImageSource="A.png" BtnId="110001001">
                   <INFOMATION ViewStartX="0" ViewStartY="0" ViewHeight="123" ViewWidth="123">
                      ABCDEFGHIJKLMN
                   </INFOMATION>
              </HOTPOINT>
              <HOTPOINT BtnStartX="0" BtnStartY="0" BtnWidth="123" BtnHeight="345" Ptype="MAP" BtnImageSource="B.png" BtnId="110001002">
                   <MAP ViewStartX="" ViewStartY="" ViewHeight="" ViewWidth="" Longitude="" Latitude="">
                   </MAP>
              </HOTPOINT>
              <HOTPOINT BtnStartX="0" BtnStartY="0" BtnWidth="123" BtnHeight="345" Ptype="SCROLL" BtnImageSource="C.png" BtnId="110001003">
                   <SCROLL ViewStartX="" ViewStartY="" ViewHeight="" ViewWidth="" CloseBtnImageSource="Close.png" ClosetnId="110001004">
                         <IMAGE ImageSource="ScrollImage1.png">
                         </IMAGE>
                         <IMAGE ImageSource="ScrollImage2.png">
                         </IMAGE>
                   </SCROLL>
              </HOTPOINT>
              <HOTPOINT BtnStartX="0" BtnStartY="0" BtnWidth="123" BtnHeight="345" Ptype="VIDEO" BtnImageSource="PLAY.png" BtnId="110001005">
                   <VIDEO ViewStartX="" ViewStartY="" ViewHeight="" ViewWidth="" InitSeconds="1" URL="http://132.228.209.22/a.movie" >
                   </VIDEO>
              </HOTPOINT>
           </PAGE>
           <PAGE ImageSource="jzzzbg002002">
              
           </PAGE>
           <PAGE ImageSource="jzzzbg002003">
              
           </PAGE>
        </ARTICLE>
        <ARTICLE NO="2">
            <PAGE ImageSource="jzzzbg003001">
              
           </PAGE>
           <PAGE ImageSource="jzzzbg003002">
              
           </PAGE>
           <PAGE ImageSource="jzzzbg003003">
              
           </PAGE>
        </ARTICLE>
      </MAGAZINE>
     */
    //NSString *readContent=@"";
    NSString* path = [[NSBundle mainBundle] pathForResource:@"TestMagazine" ofType:@"xml"];
	NSString* fileText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	//NSLog(@"path:%d , fileText:%d",[path retainCount],[fileText retainCount]);
    
	
	// parse text as xml
	NSError* error;
	GDataXMLDocument* document = [[GDataXMLDocument alloc] initWithXMLString:fileText options:0 error:&error];
	GDataXMLElement *rootNode = [document rootElement];
	//NSLog(@"%@",document);
	//NSLog(@"%@",rootNode);
	
	// get user names by xpath
	
    
    
     NSArray* skipButtonList = [rootNode nodesForXPath:@"//MAGAZINE/ARTICLE/SKIPBUTTONS" error:&error];
     NSArray*  coverList = [rootNode nodesForXPath:@"//MAGAZINE/COVER" error:&error];
     NSArray*  pageList = [rootNode nodesForXPath:@"//MAGAZINE/ARTICLE/PAGE" error:&error];//ARTICLE
     NSArray*  articleList = [rootNode nodesForXPath:@"//MAGAZINE/ARTICLE" error:&error];
	
    NSLog(@"%d",1024*([articleList count]+1));
    magazineScrollView.contentSize= CGSizeMake(1024*([articleList count]+1), 748);//CGRectMake(0, 0, 1024*3, 748);
    
    //NSLog(@"－－－  %@",userList);
	for(GDataXMLNode* node in skipButtonList) {
        SkipButtonArray=[[node stringValue ]componentsSeparatedByString:@","];
	}
    
    UIImageView *cover=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 1024, 748) ];
     //UIImageView *cover2=[[UIImageView alloc]initWithFrame:CGRectMake(1024, 0, 1024, 748) ];
    //[cover2 setImage:[UIImage imageNamed:@"page5.png"]];
    //载入封面
    
	for (int i=0; i<[coverList count]; i++) {
       
        NSString* imagea=[(GDataXMLNode*)[[coverList objectAtIndex:i]attributeForName:@"ImageSource"] stringValue];
       
        
        [cover setImage:[UIImage imageNamed:imagea]];
        
        [magazineScrollView addSubview:cover];
        
        
       // self.view=magazineScrollView;
       // [self.view addSubview:magazineScrollView];
       // [self.view insertSubview:magazineScrollView aboveSubview:self.view ];//insertSubview:magazineScrollView atIndex:0];
       // [cover release];
    }
    // [magazineScrollView addSubview:cover2];
    
  //  [cover2 release];
    [cover release];
    //收藏必须放在服务端下载，文章可能会丢失。如果收藏了此文章，则会出现问题
    
    //载入文章纵向
for (int k=0; k<[articleList count]; k++) {
    BaseUIScrollView *basescroll=[[BaseUIScrollView alloc]initWithFrame:CGRectMake((k+1)*1024,
                                                                                   0, 1024, 748)];
    
    basescroll.contentSize=CGSizeMake(1024, 748*[pageList count]);
    basescroll.pagingEnabled=YES;
    
    for (int i=0; i<[pageList count]; i++) {
         UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, i*748, 1024, 748)];
        NSString* imagea=[(GDataXMLNode*)[[pageList objectAtIndex:i]attributeForName:@"ImageSource"] stringValue];
         //NSLog(@"%@",imagea);
        [imagev setImage:[UIImage imageNamed:imagea]];
        
       // NSLog(@"%@",[(GDataXMLNode*)[pageList objectAtIndex:i] XMLString]);
        /* GDataXMLDocument* doc=(GDataXMLDocument*)[pageList objectAtIndex:i];
         GDataXMLElement *rootNode = [doc ];
         NSArray* hotpointlist = [rootNode nodesForXPath:@"//PAGE/HOTPOINT" error:&error];
        
        for(int g=0;g<[hotpointlist count];g++) {
            //SkipButtonArray=[[node stringValue ]componentsSeparatedByString:@","];
            NSLog(@"%@",[(GDataXMLNode*)[[hotpointlist objectAtIndex:g]attributeForName:@"BtnStartX"]stringValue]);
        }*/
        [basescroll addSubview:imagev];
    }
    [magazineScrollView addSubview:basescroll];
    
    //[imagev release];
    //[basescroll release];
   
}
    
    
   // [self.view insertSubview:magazineScrollView belowSubview:self.view];
    
    //[cover release]; 
	[document release];
	
    [super viewDidLoad];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    magazineScrollView.delegate=self;
    magazineScrollView.showsVerticalScrollIndicator=NO;
    magazineScrollView.showsHorizontalScrollIndicator=NO;
    
    [self loadTabBarItem];
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    //[self loadReadContent];
}



-(void)viewWillAppear:(BOOL)animated{
   [self hideBar];
}

- (void)switchme{

}






- (void)loadScrollViewWithPage:(int)page
{
    // 判断内容页面是否到了第一或者最后一页
    if (page < 0)
        return;
    if (page >= pageNumber)
        return;
    
    // replace the  if necessary         加载scrollView里的该page内容页面，自定义的MyViewController
    BaseViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[BaseViewController alloc] initWithPageNumber:page];//自定义的viewController初始方法
        [viewControllers replaceObjectAtIndex:page withObject:controller];//替换之前内容置为空的相应页面
        [controller release];
    }
    
    // add the controller's view to the scroll view 将已替换的页面再加入到scrollView中显示
    if (controller.view.superview == nil)
    {
        CGRect frame = magazineScrollView.frame;//设定该page的frame
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [magazineScrollView addSubview:controller.view];
        
        //NSDictionary *numberItem = [self.contentList objectAtIndex:page];//加载一些自定义的内容
       // controller.numberImage.image = [UIImage imageNamed:[numberItem valueForKey:ImageKey]];
        //controller.numberTitle.text = [numberItem valueForKey:NameKey];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    // 控制在页面转到50％的时候设定加载新内容
    CGFloat pageWidth = magazineScrollView.frame.size.width;
    int page = floor((magazineScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
    // 这里就可以自己设定去释放那些没有加载的内容了
}
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}
// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (UIView *)view
{
    return self.magazineScrollView;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
   // wamhvc.view = nil;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)
interfaceOrientation duration:(NSTimeInterval)duration {	
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait||interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
  ////      wamhvc.view.frame = CGRectMake(0, 0, 768, 1004);
    }
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft||interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        
     //   wamhvc.view.frame = CGRectMake(0, 0, 1024, 748);
    } 
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//	return YES;
//}

@end
