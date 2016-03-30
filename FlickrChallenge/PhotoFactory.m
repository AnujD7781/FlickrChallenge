//
//  PhotoFactory.m
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//

#import "PhotoFactory.h"
#import "Photo.h"

static PhotoFactory *sharedInstance = nil;

@implementation PhotoFactory

#pragma mark - get singleton for PhotoFactory
+(PhotoFactory*)getSharedInstance{
    if (!sharedInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[super allocWithZone:NULL]init];

        });
        
    }
    return sharedInstance;
}

#pragma mark - Factory method for Photo with UIImageType
-(UIImage*)imageFactoryForPhotoData:(Photo*)photo from: (enum _UIImageType) imageType{
    if (photo) {
            if (imageType == UIImageThumbnail && photo.urlImgThumbnailImg ) {
                return [self imgWithURL:photo.urlImgThumbnailImg];
            } else if (imageType == UIImageLightBox ) {
                if (photo.urlFullScreenImg) {
                    return [self imgWithURL:photo.urlFullScreenImg];
                } else if (photo.urlFullScreenImg_B) {
                    return [self imgWithURL:photo.urlFullScreenImg_B];
                } else if (photo.urlFullScreenImg_C) {
                    return [self imgWithURL:photo.urlFullScreenImg_C];
                }
            }
        
    }
    return nil;
}

-(UIImage*)imgWithURL:(NSURL*)URL {
    @autoreleasepool {
        NSData *imageData = [NSData dataWithContentsOfURL:URL];
        UIImage *image = [UIImage imageWithData:imageData];
        imageData = nil;
        return image;
    }
    
}

@end
