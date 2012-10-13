//
//  ViewController.m
//  MockEpic
//
//  Created by cesar on 27/08/12.
//  Copyright (c) 2012 c-bleu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *itemsMain;
@property (nonatomic, strong) NSMutableArray *itemsFocus;

//@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ViewController

@synthesize carouselMain;
@synthesize carouselFocus;
@synthesize itemsMain;
@synthesize itemsFocus;
//@synthesize images = _images;

@synthesize arcSlider, radiusSlider;
@synthesize tiltSlider, spaceSlider;
@synthesize xSlider, ySlider;
@synthesize xpSlider, ypSlider;

- (void)awakeFromNib
{
	[super awakeFromNib];
	NSLog(@"awakeFromNib ...");
	
//    //set up data sources
//    self.itemsMain = [NSMutableArray array];
//    for (int i = 0; i < 20; i++)
//    {
//        [itemsMain addObject:[NSNumber numberWithInt:i]];
//    }
//	NSLog(@"%d", itemsMain.count);
    
//    self.itemsFocus = [NSMutableArray array];
//    for (int i = 0; i < 1; i++)
//    {
//        [itemsFocus addObject:[NSNumber numberWithInt:i]];
//    }
//	NSLog(@"%d", itemsFocus.count);
		
    //get image URLs
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
    NSArray *imagePaths = [NSArray arrayWithContentsOfFile:plistPath];
    
    //remote image URLs
    NSMutableArray *URLs = [NSMutableArray array];
    for (NSString *path in imagePaths)
    {
        NSURL *URL = [NSURL URLWithString:path];
        if (URL)
        {
            [URLs addObject:URL];
        }
        else
        {
            NSLog(@"'%@' is not a valid URL", path);
        }
    }
    self.itemsMain = URLs;

	self.itemsFocus = [NSMutableArray array];

}


- (void)viewDidLoad
{
	NSLog(@"viewDidLoad");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //configure carousel
    carouselMain.type = iCarouselTypeTimeMachine;
    carouselMain.vertical = YES;
	carouselMain.scrollOffset = 20;
    carouselMain.viewpointOffset = CGSizeMake(15.0f, -0.0f);
	carouselMain.contentOffset = CGSizeMake(15.0f, -0.0f);
	
    carouselFocus.type = iCarouselTypeRotary;
    carouselFocus.vertical = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    carouselMain.delegate = nil;
    carouselMain.dataSource = nil;
    carouselFocus.delegate = nil;
    carouselFocus.dataSource = nil;
	
}

- (IBAction)reloadCarouselMain
{
    [carouselMain reloadData];
}

- (IBAction)reloadCarouselFocus
{
    [carouselFocus reloadData];
}

- (IBAction)insertItem
{
    NSInteger index = MAX(0, self.carouselFocus.currentItemIndex);
    [itemsFocus insertObject:[NSNumber numberWithInt: self.carouselFocus.numberOfItems] atIndex:index];
    [self.carouselFocus insertItemAtIndex:index animated:YES];
}

- (IBAction)removeItem
{
    if (self.carouselFocus.numberOfItems > 0)
    {
        NSInteger index = self.carouselFocus.currentItemIndex;
        [self.carouselFocus removeItemAtIndex:index animated:YES];
        [itemsFocus removeObjectAtIndex:index];
    }
}

- (IBAction)updateViewpointXOffset:(UISlider *)slider
{
	xSlider = slider.value;
    CGSize offset = CGSizeMake(xSlider, ySlider);
    carouselMain.viewpointOffset = offset;
}

- (IBAction)updateViewpointOffset:(UISlider *)slider
{
	ySlider = slider.value;
    CGSize offset = CGSizeMake(xSlider, ySlider);
    carouselMain.viewpointOffset = offset;
}

- (IBAction)updateContentXOffset:(UISlider *)slider
{
 	xpSlider = slider.value;
    CGSize offset = CGSizeMake(xpSlider, ypSlider);
	carouselMain.contentOffset = offset;
}

- (IBAction)updateContentOffset:(UISlider *)slider
{
 	ypSlider = slider.value;
    CGSize offset = CGSizeMake(xpSlider, ypSlider);
	carouselMain.contentOffset = offset;
}


#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
//	NSLog(@"numberOfItemsInCarousel");
    //return the total number of items in the carousel
    if (carousel == carouselFocus)
    {
        return [itemsFocus count];
    }
    else
    {
        return [itemsMain count];
    }
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
//	NSLog(@"carousel:viewForItemAtIndex:");
    
    //create new view if no view is available for recycling
    if (view == nil)
    {		 
		FXImageView *imageView = [[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 190.0f, 190.0f)] ;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
        imageView.reflectionScale = 0.5f;
        imageView.reflectionAlpha = 0.25f;
        imageView.reflectionGap = 10.0f;
        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
        imageView.shadowBlur = 5.0f;
        imageView.cornerRadius = 10.0f;
        view = imageView;		
    }
    
	
	//set image
//	((FXImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"plat0%d.jpg", (1 + index % 7)]];
//	NSLog(@"%d", (1+index % 7) );

	//set image with URL. FXImageView will then download and process the image
	[(FXImageView *)view setImageWithContentsOfURL:[itemsMain objectAtIndex:index]];
	
    if (carousel == carouselFocus)
    {
        view.contentMode = UIViewContentModeScaleToFill;
		view.frame =  CGRectMake(0, 0, 30.0f, 30.0f);
    }else{
		//show placeholder
		((FXImageView *)view).processedImage = [UIImage imageNamed:@"placeholder.png"];
	}
    return view;
}


- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionArc:
        {
			NSLog(@"arc:%f",self.arcSlider.value);
            if (carousel == carouselFocus)
	            return 2 * M_PI * self.arcSlider.value;
        }
        case iCarouselOptionRadius:
        {
			NSLog(@"raduis:%f",self.radiusSlider.value);
            if (carousel == carouselFocus)
	            return value * self.radiusSlider.value;
        }
        case iCarouselOptionTilt:
        {
            return tiltSlider.value;
        }
        case iCarouselOptionSpacing:
        {
            if (carousel == carouselMain)
            {
                //add a bit of spacing between the item views
                return value * spaceSlider.value;
            }
        }
        default:
        {
            return value;
        }
    }
}



@end
