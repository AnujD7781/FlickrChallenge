//
//  PhotoFactory.h
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

/*
    UIImageType represents types and size of images
 */
typedef enum _UIImageType{
    UIImageThumbnail,
    UIImageLightBox,
} UIImageType;

@interface PhotoFactory : UIImage

/*
    singleton to get UIImagePhoto factory.
 */
+(PhotoFactory*)getSharedInstance;

/*
    returns UIImage for a Photo object 
 */
-(UIImage*)imageFactoryForPhotoData:(Photo*)photo from: (enum _UIImageType) imageType;
@end
