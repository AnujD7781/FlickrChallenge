//
//  LandingScreenViewController.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "LandingPageViewController.h"

@interface LandingPageViewController ()
@end

@implementation LandingPageViewController

#pragma mark - View Lifecycle methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - BaseView Controller LifeCycle methods
-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
    [self performSegueWithIdentifier:@"CollectionViewSegue" sender:nil];

}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
