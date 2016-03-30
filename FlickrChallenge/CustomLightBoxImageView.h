//
//  CustomLightBoxImageView.h
//  FlickrChallenge
//
//  Created by ANUJ DESHMUKH on 3/28/16.
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLightBoxImageView : UIImageView <UIGestureRecognizerDelegate> {
    
@protected
    UIPinchGestureRecognizer *_pinchRecogniser;
    UIRotationGestureRecognizer *_rotateRecogniser;
    UIPanGestureRecognizer *_panRecogniser;
    UITapGestureRecognizer *_tapRecogniser;
}

/*
    Use methods to reset imageView image to original format
 */
- (void) reset;
- (void) resetWithAnimation:(BOOL)animation;

@end