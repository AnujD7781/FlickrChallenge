//
//  Photos.h
//  TrialUIHelperProject
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//  Photo Model for collectionView 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong, readonly) NSString *photoId;
@property (nonatomic, strong, readonly) NSString *owner;
@property (nonatomic, strong, readonly) NSString *secret;
@property (nonatomic, strong, readonly) NSString *server;
@property (nonatomic, strong, readonly) NSString *farm;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSURL *urlImgThumbnailImg;
@property (nonatomic, strong, readonly) NSURL *urlFullScreenImg;
@property (nonatomic, strong, readonly) NSURL *urlFullScreenImg_C;
@property (nonatomic, strong, readonly) NSURL *urlFullScreenImg_B;
@property (nonatomic, strong, readonly) UIImage *imgThumbnailImage;
@property (nonatomic, strong, readonly) UIImage *imgLightBoxImage;

-(void)initWithDictionary:(NSDictionary*)dictPhotos;

@end
