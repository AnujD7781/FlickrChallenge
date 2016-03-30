//
//  BaseViewController.h
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController
/*
    Use openrationQueue to post any view specific operation.
*/
@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;


/*
    Use method to show alert view with message and title string.
 */
-(void)showMessage:(NSString*)message withTitle:(NSString *)title;

/*
    Use this method to post network activity indicator for any operation
 */
-(void)setActivityIndicatorForView:(BOOL)isSetActivity;
@end
