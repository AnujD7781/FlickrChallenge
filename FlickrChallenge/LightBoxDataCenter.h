//
//  LightBoxDataCenter.h
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoDetails.h"
#import "Photo.h"

/*
 Implement LightBoxDataCenterDelegate to get notification for PhotoDetails data and error revceived for any LightBox Data Center delegate.
 */
@protocol LightBoxDataCenterDelegate;

@interface LightBoxDataCenter : NSObject

@property (nonatomic, weak) id<LightBoxDataCenterDelegate> delegate;


/*
    Pass Photo model to get details for photo.photoId.
 */
-(void)getImageDetailsDataForPhoto:(Photo*)photo;

@end
@protocol LightBoxDataCenterDelegate <NSObject>
@required
-(void)didReceiveDataForImageDetailsView:(PhotoDetails*)imageDetailModel;
-(void)didGetError:(NSError*)error;
@optional


@end
