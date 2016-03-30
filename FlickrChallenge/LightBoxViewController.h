//
//  LightBoxViewController.h
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "BaseViewController.h"
#import "LightBoxDataCenter.h"
@interface LightBoxViewController : BaseViewController <LightBoxDataCenterDelegate>
    // property to set photo model from MasterView controller
@property (nonatomic, strong) Photo *photo;

@end
