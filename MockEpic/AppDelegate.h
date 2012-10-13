//
//  AppDelegate.h
//  MockEpic
//
//  Created by cesar on 27/08/12.
//  Copyright (c) 2012 c-bleu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) ViewController *viewController;

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, weak) IBOutlet ViewController *viewController;


@end
