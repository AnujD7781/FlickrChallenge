//
//  BaseViewController.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () {
    int countActivity;
}

@end

@implementation BaseViewController

#pragma mark - Initialisation Overrides
-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if(self = [super initWithCoder:aDecoder]) {
        // similarly for other instance variables
        self.thumbnailQueue = [[NSOperationQueue alloc] init];
        self.thumbnailQueue.maxConcurrentOperationCount = 20;
    }
    return self;
}

#pragma mark - View Lifecycle methods
-(void)viewDidLoad {
    [super viewDidLoad];
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swiperight];
        //swiperight = nil;
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeleft];
        //swipeleft = nil;
}

#pragma mark - Custom Left Right swipe recognizer
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer {
    //Do what you want here
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer {
    //Do what you want here
}


#pragma mark - Custom Alert message Method
-(void)showMessage:(NSString*)message withTitle:(NSString *)title {
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Custom network activity method
-(void)setActivityIndicatorForView:(BOOL)isSetActivity {
    if (isSetActivity) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        countActivity ++;
    } else {
        countActivity --;
        if (countActivity == 0) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }
    }
}


@end
