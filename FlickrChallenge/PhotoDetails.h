//
//  ImageDetailDataModel.h
//  FlickrChallenge
//
//  Copyright © 2016 ANUJ_Deshmukh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoDetails : NSObject

@property (nonatomic, strong, readonly) NSString *strDescription;
@property (nonatomic, strong, readonly) NSString *strOwner;
@property (nonatomic, strong, readonly) NSString *strTitle;
@property (nonatomic, strong, readonly) NSURL *urlFlickr;

-(void)initWithDictionary:(NSDictionary*)dictPhotoDetail;
@end
