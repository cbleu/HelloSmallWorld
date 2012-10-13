//
//  ViewController.h
//  MockEpic
//
//  Created by cesar on 27/08/12.
//  Copyright (c) 2012 c-bleu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXImageView.h"
#import "iCarousel.h"

@interface ViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carouselMain;
@property (weak, nonatomic) IBOutlet iCarousel *carouselFocus;

@property (nonatomic, retain) IBOutlet UISlider *arcSlider;
@property (nonatomic, retain) IBOutlet UISlider *radiusSlider;
@property (nonatomic, retain) IBOutlet UISlider *tiltSlider;
@property (nonatomic, retain) IBOutlet UISlider *spaceSlider;

@property (nonatomic, readwrite) CGFloat xSlider, ySlider;
@property (nonatomic, readwrite) CGFloat xpSlider, ypSlider;


- (IBAction)insertItem;
- (IBAction)removeItem;
- (IBAction)reloadCarouselMain;
- (IBAction)reloadCarouselFocus;

@end

